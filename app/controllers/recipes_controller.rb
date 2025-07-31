class RecipesController < ApplicationController
  def generate
    ingredients = params[:ingredients] || []
    
    # Use the RecipeGeneratorService to generate recipes
    service = RecipeGeneratorService.new(ingredients)
    recipes = service.generate_recipes
    
    render json: {
      success: true,
      recipes: recipes
    }
  rescue => e
    Rails.logger.error("Recipe generation error: #{e.message}")
    render json: {
      success: false,
      error: "Failed to generate recipes"
    }
  end
  
  def show
    # For now, just render a simple response
    render json: { message: "Recipe details would be shown here" }
  end
  
  def save
    # For now, just return success
    render json: { 
      success: true, 
      message: "Recipe saved successfully" 
    }
  end
end 