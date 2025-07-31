require "openai"

class RecipeGeneratorService
  def initialize(ingredients)
    @ingredients = ingredients.map(&:downcase)
    @available_ingredients = @ingredients.dup
  end

  def generate_recipes
    recipes = []

    # Generate multiple recipe options based on available ingredients
    recipes << generate_pav_bhaji_recipe if can_make_pav_bhaji?
    recipes << generate_mashed_potatoes_recipe if can_make_mashed_potatoes?
    recipes << generate_pasta_recipe if can_make_pasta?
    recipes << generate_chicken_recipe if can_make_chicken?
    recipes << generate_breakfast_recipe if can_make_breakfast?
    recipes << generate_soup_recipe if can_make_soup?
    recipes << generate_salad_recipe if can_make_salad?
    recipes << generate_dessert_recipe if can_make_dessert?

    # If no specific recipes match, generate a basic recipe
    if recipes.empty?
      recipes << generate_basic_recipe
    end

    recipes.compact
  end

  private

  def can_make_pav_bhaji?
    has_ingredient?("potatoes") && (has_ingredient?("pav bread") || has_ingredient?("bread"))
  end

  def can_make_mashed_potatoes?
    has_ingredient?("potatoes") && (has_ingredient?("butter") || has_ingredient?("milk"))
  end

  def can_make_pasta?
    has_ingredient?("pasta") || has_ingredient?("macaroni") || has_ingredient?("spaghetti")
  end

  def can_make_chicken?
    has_ingredient?("chicken")
  end

  def can_make_breakfast?
    has_ingredient?("flour") || has_ingredient?("eggs") || has_ingredient?("milk")
  end

  def can_make_soup?
    has_ingredient?("vegetables") || has_ingredient?("broth") || has_ingredient?("soup")
  end

  def can_make_salad?
    has_ingredient?("lettuce") || has_ingredient?("tomato") || has_ingredient?("cucumber")
  end

  def can_make_dessert?
    has_ingredient?("sugar") || has_ingredient?("flour") || has_ingredient?("chocolate")
  end

  def has_ingredient?(ingredient)
    @available_ingredients.any? { |i| i.include?(ingredient) }
  end

  def generate_pav_bhaji_recipe
    {
      title: "Pav Bhaji",
      difficulty: "Medium",
      prep_time: 20,
      cook_time: 30,
      servings: 4,
      description: "A popular Indian street food with spiced mashed vegetables served with buttered bread rolls.",
      ingredients: [
        { quantity: "4", unit: "medium", name: "potatoes, boiled and mashed" },
        { quantity: "2", unit: "medium", name: "tomatoes, finely chopped" },
        { quantity: "1", unit: "large", name: "onion, finely chopped" },
        { quantity: "1", unit: "medium", name: "bell pepper, finely chopped" },
        { quantity: "8", unit: "pieces", name: "pav bread" },
        { quantity: "3", unit: "tbsp", name: "butter" },
        { quantity: "2", unit: "tsp", name: "pav bhaji masala" },
        { quantity: "1", unit: "tsp", name: "red chili powder" },
        { quantity: "to taste", unit: "", name: "salt" },
        { quantity: "1", unit: "tbsp", name: "lemon juice" }
      ],
      instructions: [
        "Heat butter in a large pan over medium heat",
        "Add chopped onions and sauté until golden brown",
        "Add chopped bell peppers and cook for 2-3 minutes",
        "Add chopped tomatoes and cook until soft",
        "Add pav bhaji masala, red chili powder, and salt",
        "Add mashed potatoes and mix well",
        "Cook for 5-7 minutes, stirring occasionally",
        "Add lemon juice and mix well",
        "Toast pav bread with butter until golden",
        "Serve hot bhaji with buttered pav bread"
      ]
    }
  end

  def generate_mashed_potatoes_recipe
    {
      title: "Creamy Mashed Potatoes",
      difficulty: "Easy",
      prep_time: 15,
      cook_time: 25,
      servings: 4,
      description: "Smooth and fluffy mashed potatoes with butter and milk - the perfect comfort food.",
      ingredients: [
        { quantity: "4", unit: "large", name: "potatoes, peeled and cubed" },
        { quantity: "4", unit: "tbsp", name: "butter" },
        { quantity: "1/2", unit: "cup", name: "milk" },
        { quantity: "1", unit: "tsp", name: "salt" },
        { quantity: "1/2", unit: "tsp", name: "black pepper" },
        { quantity: "2", unit: "cloves", name: "garlic, minced (optional)" }
      ],
      instructions: [
        "Peel and cube potatoes into 1-inch pieces",
        "Place potatoes in a large pot and cover with cold water",
        "Add 1 teaspoon salt to the water",
        "Bring to a boil over high heat",
        "Reduce heat to medium and simmer for 15-20 minutes until tender",
        "Drain potatoes and return to the pot",
        "Add butter, milk, salt, and pepper",
        "Mash potatoes with a potato masher until smooth",
        "If using garlic, add minced garlic and mix well",
        "Serve hot with extra butter on top"
      ]
    }
  end

  def generate_pasta_recipe
    {
      title: "Creamy Pasta Delight",
      difficulty: "Easy",
      prep_time: 10,
      cook_time: 20,
      servings: 4,
      description: "A simple and delicious pasta dish using your available ingredients.",
      ingredients: [
        { quantity: "1", unit: "lb", name: "pasta" },
        { quantity: "2", unit: "tbsp", name: "olive oil" },
        { quantity: "3", unit: "cloves", name: "garlic, minced" },
        { quantity: "1/2", unit: "cup", name: "parmesan cheese" },
        { quantity: "to taste", unit: "", name: "salt and pepper" },
        { quantity: "1/4", unit: "cup", name: "fresh herbs (optional)" }
      ],
      instructions: [
        "Bring a large pot of salted water to boil",
        "Cook pasta according to package directions until al dente",
        "While pasta cooks, heat olive oil in a large pan over medium heat",
        "Add minced garlic and sauté for 1-2 minutes until fragrant",
        "Drain pasta, reserving 1 cup of pasta water",
        "Add pasta to the pan with garlic and oil",
        "Add parmesan cheese and toss to combine",
        "Add reserved pasta water as needed to create a creamy sauce",
        "Season with salt and pepper to taste",
        "Garnish with fresh herbs if available and serve immediately"
      ]
    }
  end

  def generate_chicken_recipe
    {
      title: "Simple Garlic Chicken",
      difficulty: "Easy",
      prep_time: 15,
      cook_time: 25,
      servings: 4,
      description: "A flavorful chicken dish that's perfect for any night of the week.",
      ingredients: [
        { quantity: "4", unit: "pieces", name: "chicken breasts" },
        { quantity: "3", unit: "tbsp", name: "olive oil" },
        { quantity: "4", unit: "cloves", name: "garlic, minced" },
        { quantity: "1", unit: "tsp", name: "dried herbs" },
        { quantity: "to taste", unit: "", name: "salt and pepper" },
        { quantity: "1/2", unit: "cup", name: "chicken broth (optional)" }
      ],
      instructions: [
        "Season chicken breasts with salt and pepper on both sides",
        "Heat olive oil in a large skillet over medium-high heat",
        "Add chicken breasts and cook for 6-8 minutes per side until golden brown",
        "Reduce heat to medium and add minced garlic",
        "Cook garlic for 1-2 minutes until fragrant",
        "Add dried herbs and stir to combine",
        "If using broth, add it to the pan and simmer for 2-3 minutes",
        "Cook chicken until internal temperature reaches 165°F",
        "Let chicken rest for 5 minutes before serving",
        "Serve with your favorite side dish"
      ]
    }
  end

  def generate_breakfast_recipe
    {
      title: "Fluffy Pancakes",
      difficulty: "Easy",
      prep_time: 10,
      cook_time: 15,
      servings: 4,
      description: "Light and fluffy pancakes perfect for a weekend breakfast.",
      ingredients: [
        { quantity: "2", unit: "cups", name: "all-purpose flour" },
        { quantity: "2", unit: "tbsp", name: "sugar" },
        { quantity: "2", unit: "tsp", name: "baking powder" },
        { quantity: "1/2", unit: "tsp", name: "salt" },
        { quantity: "2", unit: "", name: "large eggs" },
        { quantity: "1 3/4", unit: "cups", name: "milk" },
        { quantity: "1/4", unit: "cup", name: "melted butter" },
        { quantity: "1", unit: "tsp", name: "vanilla extract" }
      ],
      instructions: [
        "In a large bowl, whisk together flour, sugar, baking powder, and salt",
        "In a separate bowl, beat eggs, then add milk, melted butter, and vanilla",
        "Pour wet ingredients into dry ingredients and stir until just combined",
        "Let batter rest for 5 minutes",
        "Heat a griddle or large skillet over medium heat",
        "Lightly grease the cooking surface",
        "Pour 1/4 cup batter for each pancake",
        "Cook until bubbles form on the surface, about 2-3 minutes",
        "Flip and cook the other side until golden brown",
        "Serve hot with butter and maple syrup"
      ]
    }
  end

  def generate_soup_recipe
    {
      title: "Hearty Vegetable Soup",
      difficulty: "Easy",
      prep_time: 15,
      cook_time: 45,
      servings: 6,
      description: "A comforting soup that's perfect for using up vegetables.",
      ingredients: [
        { quantity: "2", unit: "tbsp", name: "olive oil" },
        { quantity: "1", unit: "large", name: "onion, diced" },
        { quantity: "3", unit: "cloves", name: "garlic, minced" },
        { quantity: "4", unit: "cups", name: "vegetables, chopped" },
        { quantity: "6", unit: "cups", name: "vegetable broth" },
        { quantity: "1", unit: "tsp", name: "dried herbs" },
        { quantity: "to taste", unit: "", name: "salt and pepper" }
      ],
      instructions: [
        "Heat olive oil in a large pot over medium heat",
        "Add diced onion and cook until softened, about 5 minutes",
        "Add minced garlic and cook for 1 minute until fragrant",
        "Add chopped vegetables and cook for 5 minutes",
        "Pour in vegetable broth and bring to a boil",
        "Reduce heat and simmer for 30-40 minutes until vegetables are tender",
        "Season with herbs, salt, and pepper to taste",
        "Let soup cool slightly before serving",
        "Garnish with fresh herbs if available"
      ]
    }
  end

  def generate_salad_recipe
    {
      title: "Fresh Garden Salad",
      difficulty: "Easy",
      prep_time: 15,
      cook_time: 0,
      servings: 4,
      description: "A refreshing salad that's perfect for any meal.",
      ingredients: [
        { quantity: "4", unit: "cups", name: "mixed greens" },
        { quantity: "1", unit: "large", name: "tomato, sliced" },
        { quantity: "1", unit: "medium", name: "cucumber, sliced" },
        { quantity: "1/4", unit: "cup", name: "olive oil" },
        { quantity: "2", unit: "tbsp", name: "vinegar" },
        { quantity: "to taste", unit: "", name: "salt and pepper" }
      ],
      instructions: [
        "Wash and dry all vegetables thoroughly",
        "Tear or chop greens into bite-sized pieces",
        "Slice tomato and cucumber into thin slices",
        "In a small bowl, whisk together olive oil, vinegar, salt, and pepper",
        "In a large bowl, combine greens, tomato, and cucumber",
        "Drizzle with dressing and toss gently to combine",
        "Serve immediately for best freshness",
        "Add additional toppings like cheese or nuts if desired"
      ]
    }
  end

  def generate_dessert_recipe
    {
      title: "Simple Vanilla Cake",
      difficulty: "Medium",
      prep_time: 20,
      cook_time: 30,
      servings: 8,
      description: "A classic vanilla cake that's perfect for any celebration.",
      ingredients: [
        { quantity: "2", unit: "cups", name: "all-purpose flour" },
        { quantity: "1 1/2", unit: "cups", name: "sugar" },
        { quantity: "1/2", unit: "cup", name: "butter, softened" },
        { quantity: "3", unit: "", name: "large eggs" },
        { quantity: "1", unit: "cup", name: "milk" },
        { quantity: "2", unit: "tsp", name: "vanilla extract" },
        { quantity: "2", unit: "tsp", name: "baking powder" },
        { quantity: "1/2", unit: "tsp", name: "salt" }
      ],
      instructions: [
        "Preheat oven to 350°F and grease a 9-inch cake pan",
        "In a large bowl, cream butter and sugar until light and fluffy",
        "Add eggs one at a time, beating well after each addition",
        "Mix in vanilla extract",
        "In a separate bowl, whisk together flour, baking powder, and salt",
        "Alternately add flour mixture and milk to butter mixture",
        "Pour batter into prepared pan and smooth the top",
        "Bake for 25-30 minutes until a toothpick comes out clean",
        "Let cake cool in pan for 10 minutes, then transfer to wire rack",
        "Frost with your favorite frosting or serve plain"
      ]
    }
  end

  def generate_basic_recipe
    {
      title: "Simple Stir-Fry",
      difficulty: "Easy",
      prep_time: 15,
      cook_time: 10,
      servings: 4,
      description: "A quick and easy stir-fry using your available ingredients.",
      ingredients: [
        { quantity: "2", unit: "tbsp", name: "oil" },
        { quantity: "2", unit: "cloves", name: "garlic, minced" },
        { quantity: "1", unit: "medium", name: "onion, sliced" },
        { quantity: "4", unit: "cups", name: "mixed vegetables" },
        { quantity: "2", unit: "tbsp", name: "soy sauce" },
        { quantity: "to taste", unit: "", name: "salt and pepper" }
      ],
      instructions: [
        "Heat oil in a large wok or skillet over high heat",
        "Add minced garlic and cook for 30 seconds until fragrant",
        "Add sliced onion and cook for 2 minutes until softened",
        "Add vegetables and stir-fry for 5-7 minutes until crisp-tender",
        "Add soy sauce and season with salt and pepper",
        "Continue cooking for 1-2 minutes until vegetables are coated",
        "Serve hot over rice or noodles if available",
        "Garnish with fresh herbs if desired"
      ]
    }
  end
end
