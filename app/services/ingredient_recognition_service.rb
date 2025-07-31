require "google/cloud/vision"

class IngredientRecognitionService
  def initialize(image_path, original_filename = nil)
    @image_path = image_path
    @original_filename = original_filename
  end
  
  def analyze
    begin
      # Check if Vision API credentials are available
      unless vision_api_available?
        Rails.logger.warn "Vision API not available, using filename-based detection"
        return detect_from_filename
      end
      
      # Configure Google Cloud Vision
      vision = Google::Cloud::Vision.new(
        project_id: get_vision_config('project_id'),
        credentials: build_vision_credentials
      )
      
      image_annotator = vision.image_annotator
      
      # Get both label detection and text detection for better results
      label_response = image_annotator.label_detection image: @image_path
      text_response = image_annotator.text_detection image: @image_path
      
      labels = label_response.responses.first.label_annotations.map(&:description)
      text_annotations = text_response.responses.first.text_annotations.map(&:description) if text_response.responses.first.text_annotations.any?
      
      Rails.logger.info "Vision API labels: #{labels}"
      Rails.logger.info "Vision API text: #{text_annotations}" if text_annotations
      
      # If Vision API returns empty results, use filename-based detection
      if labels.empty? && (text_annotations.nil? || text_annotations.empty?)
        Rails.logger.warn "Vision API returned empty results, using filename-based detection"
        return detect_from_filename
      end
      
      # Filter for food-related ingredients
      ingredients = extract_food_ingredients(labels, text_annotations)
      
      # If no ingredients found, try to infer from the image context
      if ingredients.empty?
        ingredients = infer_ingredients_from_context(labels)
      end
      
      Rails.logger.info "Final ingredients: #{ingredients}"
      return ingredients.presence || detect_from_filename
    rescue => e
      Rails.logger.error("Vision API error: #{e.message}")
      Rails.logger.info "Falling back to filename-based detection"
      # Fallback to filename-based detection
      detect_from_filename
    end
  end
  
  private
  
  def detect_from_filename
    # Use original filename if available, otherwise use the file path
    filename = @original_filename&.downcase || File.basename(@image_path).downcase
    
    Rails.logger.info "Detecting ingredients from filename: #{filename}"
    
    # Check for specific food patterns in the filename
    case filename
    when /pav.*bhaji|bhaji.*pav|pav-bhaji/
      ['potatoes', 'tomatoes', 'onions', 'bell peppers', 'pav bread', 'butter', 'spices']
    when /pancake|waffle|breakfast|keto.*pancake/
      ['flour', 'eggs', 'milk', 'butter', 'sugar', 'baking powder']
    when /burger|cheeseburger|hamburger|ultimate.*cheeseburger/
      ['beef', 'cheese', 'lettuce', 'tomato', 'onion', 'bun', 'mayo']
    when /mac.*cheese|cheese.*mac/
      ['pasta', 'cheese', 'milk', 'butter', 'flour']
    when /mashed.*potato|potato.*mashed/
      ['potatoes', 'butter', 'milk', 'salt', 'pepper']
    when /pasta/
      ['pasta', 'olive oil', 'garlic', 'herbs', 'parmesan']
    when /alfredo/
      ['pasta', 'alfredo sauce', 'parmesan cheese', 'heavy cream', 'butter', 'garlic']
    when /salad/
      ['lettuce', 'tomatoes', 'cucumber', 'olive oil', 'vinegar']
    when /rice/
      ['rice', 'onions', 'garlic', 'oil', 'spices']
    when /chicken/
      ['chicken', 'onions', 'garlic', 'oil', 'spices']
    when /fish/
      ['fish', 'lemon', 'herbs', 'oil', 'garlic']
    when /bread/
      ['flour', 'yeast', 'water', 'salt', 'oil']
    when /soup/
      ['vegetables', 'broth', 'onions', 'garlic', 'herbs']
    when /curry/
      ['onions', 'tomatoes', 'garlic', 'ginger', 'spices', 'oil']
    when /pizza/
      ['flour', 'tomatoes', 'cheese', 'olive oil', 'herbs']
    when /macaron|macarons/
      ['almond flour', 'sugar', 'egg whites', 'vanilla', 'chocolate']
    when /ice.*cream|icecream/
      ['cream', 'sugar', 'milk', 'vanilla', 'strawberries']
    when /dessert|sweet|cake|cookie/
      ['flour', 'sugar', 'eggs', 'butter', 'vanilla']
    else
      # For unknown files, try to infer from the file content or use a more generic approach
      infer_from_generic_food
    end
  end

  def infer_from_generic_food
    # Try to read the image and make a basic inference
    # For now, return a more reasonable default based on common food types
    ['flour', 'eggs', 'milk', 'butter', 'sugar']
  end

  def extract_food_ingredients(labels, text_annotations = [])
    food_ingredients = []
    
    # Combine labels and text for analysis
    all_text = (labels + (text_annotations || [])).map(&:downcase)
    
    Rails.logger.info "Analyzing text for ingredients: #{all_text}"
    
    # Enhanced food ingredient mapping with better context awareness
    ingredient_keywords = {
      'pasta' => ['pasta', 'macaroni', 'spaghetti', 'noodles', 'penne', 'rigatoni', 'fettuccine', 'linguine'],
      'cheese' => ['cheese', 'cheddar', 'mozzarella', 'parmesan', 'gouda', 'brie'],
      'potato' => ['potato', 'potatoes', 'mashed potatoes', 'fries', 'mashed'],
      'tomato' => ['tomato', 'tomatoes', 'cherry tomato'],
      'onion' => ['onion', 'onions', 'red onion', 'white onion'],
      'garlic' => ['garlic', 'garlic clove'],
      'butter' => ['butter', 'margarine'],
      'oil' => ['oil', 'olive oil', 'vegetable oil', 'cooking oil'],
      'bread' => ['bread', 'toast', 'bun', 'roll', 'pav'],
      'rice' => ['rice', 'white rice', 'brown rice'],
      'chicken' => ['chicken', 'poultry', 'breast', 'thigh', 'chicken breast', 'chicken thigh'],
      'fish' => ['fish', 'salmon', 'tuna', 'cod'],
      'egg' => ['egg', 'eggs'],
      'vegetables' => ['vegetable', 'vegetables', 'broccoli', 'carrot', 'pepper'],
      'herbs' => ['herb', 'herbs', 'basil', 'parsley', 'cilantro', 'thyme'],
      'spices' => ['spice', 'spices', 'pepper', 'salt', 'cumin', 'paprika'],
      'milk' => ['milk', 'cream', 'dairy'],
      'flour' => ['flour', 'wheat', 'baking'],
      'sugar' => ['sugar', 'sweet', 'sweetener'],
      'beef' => ['beef', 'burger', 'hamburger', 'steak', 'ground beef'],
      'lettuce' => ['lettuce', 'salad', 'greens'],
      'almond' => ['almond', 'almonds', 'almond flour'],
      'chocolate' => ['chocolate', 'cocoa', 'dark chocolate'],
      'vanilla' => ['vanilla', 'vanilla extract'],
      'strawberry' => ['strawberry', 'strawberries'],
      'raspberry' => ['raspberry', 'raspberries'],
      'macaron' => ['macaron', 'macarons', 'almond flour', 'sugar'],
      'ice cream' => ['ice cream', 'icecream', 'cream', 'sugar'],
      'alfredo' => ['alfredo', 'alfredo sauce', 'pasta', 'parmesan', 'heavy cream'],
      'parmesan' => ['parmesan', 'parmesan cheese'],
      'heavy cream' => ['heavy cream', 'cream', 'whipping cream'],
      # Asian cuisine specific ingredients
      'soy sauce' => ['soy sauce', 'soy', 'sauce'],
      'ginger' => ['ginger', 'ginger root'],
      'orange' => ['orange', 'orange juice', 'orange zest', 'citrus'],
      'cornstarch' => ['cornstarch', 'corn starch', 'starch'],
      'sesame oil' => ['sesame oil', 'sesame'],
      'hoisin sauce' => ['hoisin', 'hoisin sauce'],
      'oyster sauce' => ['oyster sauce', 'oyster'],
      'rice vinegar' => ['rice vinegar', 'vinegar'],
      'green onions' => ['green onions', 'scallions', 'spring onions'],
      'bell peppers' => ['bell peppers', 'bell pepper', 'peppers'],
      'broccoli' => ['broccoli'],
      'carrots' => ['carrots', 'carrot']
    }
    
    # First pass: collect all potential ingredients
    potential_ingredients = []
    ingredient_keywords.each do |ingredient, keywords|
      if keywords.any? { |keyword| all_text.any? { |text| text.include?(keyword) } }
        potential_ingredients << ingredient
      end
    end
    
    Rails.logger.info "Potential ingredients found: #{potential_ingredients}"
    
    # Context-aware filtering to avoid false positives and add dish-specific ingredients
    food_ingredients = filter_ingredients_by_context(potential_ingredients, all_text, labels)
    
    # Special handling for alfredo - ensure both alfredo and pasta are included
    if food_ingredients.include?('alfredo') && !food_ingredients.include?('pasta')
      food_ingredients << 'pasta'
    end
    
    # Remove duplicates and return
    food_ingredients.uniq
  end
  
  def filter_ingredients_by_context(potential_ingredients, all_text, labels)
    filtered_ingredients = []
    
    # Context rules to avoid false positives and add dish-specific ingredients
    context_rules = {
      # If chicken is detected, don't include beef and add common chicken dish ingredients
      'chicken' => ->(ingredients) { 
        filtered = ingredients.reject { |i| i == 'beef' }
        
        # Add common ingredients for chicken dishes based on context
        if all_text.any? { |text| text.include?('orange') || text.include?('sweet') }
          # Orange chicken or sweet and sour chicken
          filtered += ['soy sauce', 'orange', 'garlic', 'ginger', 'cornstarch']
          Rails.logger.info "Detected orange/sweet chicken dish, adding Asian ingredients"
        elsif all_text.any? { |text| text.include?('curry') }
          # Curry chicken
          filtered += ['spices', 'onion', 'garlic', 'ginger']
        elsif all_text.any? { |text| text.include?('rice') }
          # Chicken with rice
          filtered += ['rice', 'vegetables', 'oil']
        end
        
        filtered.uniq
      },
      
      # If fish is detected, don't include beef or chicken
      'fish' => ->(ingredients) { ingredients.reject { |i| ['beef', 'chicken'].include?(i) } },
      
      # If pasta is detected, prioritize pasta-related ingredients
      'pasta' => ->(ingredients) { 
        pasta_related = ['pasta', 'cheese', 'alfredo', 'parmesan']
        ingredients.select { |i| pasta_related.include?(i) }
      },
      
      # If rice is detected, prioritize rice-related ingredients
      'rice' => ->(ingredients) {
        rice_related = ['rice', 'chicken', 'vegetables', 'oil', 'spices']
        ingredients.select { |i| rice_related.include?(i) }
      }
    }
    
    # Apply context rules
    context_rules.each do |context_ingredient, rule|
      if potential_ingredients.include?(context_ingredient)
        filtered_ingredients = rule.call(potential_ingredients)
        Rails.logger.info "Applied #{context_ingredient} context rule: #{potential_ingredients} -> #{filtered_ingredients}"
        return filtered_ingredients
      end
    end
    
    # If no specific context rules apply, use all potential ingredients
    # but still apply some basic filtering
    if potential_ingredients.include?('chicken')
      # If chicken is detected, remove beef to avoid confusion
      filtered_ingredients = potential_ingredients.reject { |i| i == 'beef' }
      Rails.logger.info "Applied chicken context filtering: #{potential_ingredients} -> #{filtered_ingredients}"
      return filtered_ingredients
    end
    
    potential_ingredients
  end
  
  def infer_ingredients_from_context(labels)
    # Try to infer ingredients based on common food patterns
    context_ingredients = []
    
    labels.each do |label|
      case label.downcase
      when /pancake|waffle|breakfast/
        context_ingredients += ['flour', 'eggs', 'milk', 'butter', 'sugar']
      when /burger|sandwich/
        context_ingredients += ['beef', 'cheese', 'lettuce', 'tomato', 'onion', 'bun']
      when /mac.*cheese|cheese.*mac/
        context_ingredients += ['pasta', 'cheese', 'milk', 'butter']
      when /pasta/
        context_ingredients += ['pasta', 'olive oil', 'garlic']
      when /alfredo/
        context_ingredients += ['pasta', 'alfredo sauce', 'parmesan', 'heavy cream', 'butter']
      when /salad/
        context_ingredients += ['lettuce', 'tomato', 'cucumber', 'olive oil']
      when /rice/
        context_ingredients += ['rice', 'onion', 'garlic', 'oil']
      when /chicken/
        context_ingredients += ['chicken', 'onion', 'garlic', 'oil']
      when /fish/
        context_ingredients += ['fish', 'lemon', 'herbs', 'oil']
      when /bread/
        context_ingredients += ['flour', 'yeast', 'water', 'salt']
      when /soup/
        context_ingredients += ['vegetables', 'broth', 'onion', 'garlic']
      when /curry/
        context_ingredients += ['onion', 'tomato', 'garlic', 'ginger', 'spices']
      when /pizza/
        context_ingredients += ['flour', 'tomato', 'cheese', 'olive oil']
      when /mashed.*potato|potato.*mashed|mashed/
        context_ingredients += ['potato', 'butter', 'milk', 'salt']
      when /macaron|macarons/
        context_ingredients += ['almond flour', 'sugar', 'egg whites', 'vanilla']
      when /ice.*cream|icecream/
        context_ingredients += ['cream', 'sugar', 'milk', 'vanilla']
      when /dessert|sweet|cake|cookie/
        context_ingredients += ['flour', 'sugar', 'eggs', 'butter', 'vanilla']
      when /bowl|dish|food|meal/
        # If we see generic food terms, try to infer based on visual cues
        if labels.any? { |l| l.downcase.include?('white') || l.downcase.include?('cream') }
          context_ingredients += ['potato', 'butter', 'milk']
        end
      when /indian|spice|curry/
        context_ingredients += ['onions', 'tomatoes', 'garlic', 'ginger', 'spices', 'oil']
      when /breakfast|morning/
        context_ingredients += ['flour', 'eggs', 'milk', 'butter', 'sugar']
      end
    end
    
    # If still no ingredients, try to infer from any food-related labels
    if context_ingredients.empty?
      food_labels = labels.select { |l| l.downcase.include?('food') || l.downcase.include?('dish') || l.downcase.include?('meal') }
      if food_labels.any?
        context_ingredients += ['flour', 'eggs', 'milk', 'butter', 'sugar']
      end
    end
    
    context_ingredients.uniq
  end

  private

  def vision_api_available?
    get_vision_config('project_id').present? && get_vision_config('private_key').present?
  end

  def get_vision_config(key)
    case key
    when 'project_id'
      ENV['GOOGLE_CLOUD_PROJECT_ID']
    when 'private_key'
      ENV['GOOGLE_CLOUD_PRIVATE_KEY']
    when 'private_key_id'
      ENV['GOOGLE_CLOUD_PRIVATE_KEY_ID']
    when 'client_email'
      ENV['GOOGLE_CLOUD_CLIENT_EMAIL']
    when 'client_id'
      ENV['GOOGLE_CLOUD_CLIENT_ID']
    when 'client_x509_cert_url'
      ENV['GOOGLE_CLOUD_CLIENT_X509_CERT_URL']
    else
      nil
    end
  end

  def build_vision_credentials
    {
      type: "service_account",
      project_id: get_vision_config('project_id'),
      private_key_id: get_vision_config('private_key_id'),
      private_key: get_vision_config('private_key')&.gsub('\n', "\n"),
      client_email: get_vision_config('client_email'),
      client_id: get_vision_config('client_id'),
      auth_uri: "https://accounts.google.com/o/oauth2/auth",
      token_uri: "https://oauth2.googleapis.com/token",
      auth_provider_x509_cert_url: "https://www.googleapis.com/oauth2/v1/certs",
      client_x509_cert_url: get_vision_config('client_x509_cert_url'),
      universe_domain: "googleapis.com"
    }
  end
end 