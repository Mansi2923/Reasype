class IngredientPhoto
  attr_accessor :id, :user_id, :image_path

  def initialize(attributes = {})
    @id = attributes[:id] || SecureRandom.uuid
    @user_id = attributes[:user_id]
    @image_path = attributes[:image_path] || "/uploads/#{@id}/image.jpg"
  end

  def save
    # In a real implementation, this would save to a database
    # For now, just return true to simulate success
    true
  end

  def self.create(attributes = {})
    new(attributes).tap(&:save)
  end
end
