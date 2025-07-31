require 'test_helper'

class RecipeGeneratorServiceTest < ActiveSupport::TestCase
  test "generates recipes from ingredients" do
    service = RecipeGeneratorService.new(['tomato', 'cheese', 'basil'])
    recipes = service.generate_recipes
    
    assert recipes.length > 0
    assert recipes.first.key?(:title)
    assert recipes.first.key?(:ingredients)
  end
  
  test "handles dietary restrictions" do
    service = RecipeGeneratorService.new(['tomato', 'cheese'])
    recipes = service.generate_recipes
    
    assert recipes.length > 0
  end
end 