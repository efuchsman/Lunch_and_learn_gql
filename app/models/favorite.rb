class Favorite < ApplicationRecord
  belongs_to :user

  validates_presence_of :country
  validates_presence_of :recipe_title
  validates_presence_of :recipe_link
end

