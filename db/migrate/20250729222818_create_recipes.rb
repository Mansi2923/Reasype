class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :description
      t.text :instructions
      t.integer :prep_time
      t.integer :cook_time
      t.integer :servings
      t.string :difficulty
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
