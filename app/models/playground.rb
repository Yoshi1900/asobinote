class Playground < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :posts, dependent: :destroy
  belongs_to :user
  has_many_attached :playground_images

  def get_playground_image(width, height)
    unless playground_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      playground_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    playground_image.variant(resize_to_limit: [width, height]).processed
  end

end
