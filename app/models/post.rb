class Post < ApplicationRecord
    belongs_to :playground
    belongs_to :user
    has_many :post_comments, dependent: :destroy
    has_one_attached :post_image

  
    def get_post_image
      unless post_image.attached?
        file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
        post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      post_image.variant(resize_to_limit: [100, 100]).processed
    end
end
