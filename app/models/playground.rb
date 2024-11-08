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

  validate :image_count_within_limit

  private

  def image_count_within_limit
    if playground_images.attached? && playground_images.count > 8
      errors.add(:playground_images, "は合計8枚までしかアップロードできません。")
    end
  end


end
