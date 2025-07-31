class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def health
    render json: { status: "ok", message: "Reasype API is running" }
  end

  def analyze_ingredients
    # Handle image upload and ingredient analysis
    if params[:image]
      # Process the image and return ingredients
      ingredients = ["tomato", "onion", "garlic"] # Placeholder
      render json: { 
        success: true, 
        ingredients: ingredients,
        recipes: generate_recipes(ingredients)
      }
    else
      render json: { success: false, error: "No image provided" }, status: 400
    end
  end

  private

  def generate_recipes(ingredients)
    # Simple recipe generation logic
    if ingredients.include?("tomato") && ingredients.include?("onion")
      [{ name: "Tomato Onion Salad", ingredients: ingredients }]
    else
      [{ name: "Mixed Vegetable Dish", ingredients: ingredients }]
    end
  end
end 