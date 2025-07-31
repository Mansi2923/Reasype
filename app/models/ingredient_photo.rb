class IngredientPhoto
  attr_accessor :id, :user_id, :image_path, :recognized_ingredients, :analysis_status, :image_data

  def initialize(attributes = {})
    @id = attributes[:id] || SecureRandom.uuid
    @user_id = attributes[:user_id]
    @image_path = attributes[:image_path] || "/uploads/#{@id}/image.jpg"
    @recognized_ingredients = attributes[:recognized_ingredients] || []
    @analysis_status = attributes[:analysis_status] || "processing"
    @image_data = attributes[:image_data]
  end

  def save
    # In a real implementation, this would save to a database
    # For now, just return true to simulate success
    true
  end

  def update(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
    true
  end

  def self.create(attributes = {})
    new(attributes).tap(&:save)
  end
end
