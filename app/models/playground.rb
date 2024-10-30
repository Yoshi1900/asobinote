class Playground < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :posts, dependent: :destroy
  belongs_to :user
  has_one_attached :playground_image
end
