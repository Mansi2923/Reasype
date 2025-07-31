class User < ApplicationRecord
  has_many :recipes
  has_many :ingredient_photos
  has_many :cooking_sessions
end
