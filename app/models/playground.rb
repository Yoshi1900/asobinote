class Playground < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :posts, dependent: :destroy
  belongs_to :user
  has_many_attached :playground_images

  def get_playground_image
    unless playground_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      playground_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    playground_image.variant(resize_to_limit: [100, 100]).processed
  end

  validate :validate_image_count

  private

  def validate_image_count
    if playground_images.attached? && playground_images.count > 5
      errors.add(:playground_images, "は5枚までしかアップロードできません。")
    end
  end


end
