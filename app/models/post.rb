class Post < ApplicationRecord
    belongs_to :playground
    belongs_to :user
    has_many :post_comments, dependent: :destroy
    has_one_attached :post_image
end
