class IngredientPhoto < ApplicationRecord
  belongs_to :user

  # For now, we'll use a simple approach without Shrine
  # In production, you'd want to use Shrine or Active Storage

  def image_path
    # For now, return a placeholder path
    # In a real implementation, this would return the actual image path
    "/uploads/#{id}/image.jpg"
  end
end
