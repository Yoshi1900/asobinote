class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :playgrounds, through: :taggings

  validates :name, presence:true, length:{maximum:50}
end
