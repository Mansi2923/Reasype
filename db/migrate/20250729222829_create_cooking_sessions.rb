class CreateCookingSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :cooking_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.integer :current_step
      t.datetime :started_at
      t.string :status

      t.timestamps
    end
  end
end
