class AnalyzeIngredientsJob
  include Sidekiq::Job

  def perform(photo_id)
    photo = IngredientPhoto.find(photo_id)
    photo.update(analysis_status: "processing")

    # For now, we'll simulate the analysis
    # In production, you'd use the actual image file
    service = IngredientRecognitionService.new(photo.image_path)
    ingredients = service.analyze

    photo.update(
      recognized_ingredients: ingredients,
      analysis_status: "completed"
    )
  end
end
