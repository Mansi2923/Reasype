class CreateIngredientPhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :ingredient_photos do |t|
      t.references :user, null: false, foreign_key: true
      t.text :image_data
      t.text :recognized_ingredients
      t.string :analysis_status

      t.timestamps
    end
  end
end
