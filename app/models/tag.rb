class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :playgrounds, through: :taggings
  has_many :posts, through: :taggings

  validates :name, presence:true, length:{maximum:50}

  def self.looks(search, word)
    if search == "perfect_match"
      where("name LIKE ?", "#{word}")
    elsif search == "forward_match"
      where("name LIKE ?", "#{word}%")
    elsif search == "backward_match"
      where("name LIKE ?", "%#{word}")
    elsif search == "partial_match"
      where("name LIKE ?", "%#{word}%")
    else
      all
    end
  end

end
