class Playground < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :posts, dependent: :destroy
  belongs_to :user
  has_one_attached :playground_image

  def get_playground_image
    unless playground_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      playground_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    playground_image.variant(resize_to_limit: [100, 100]).processed
  end

end
