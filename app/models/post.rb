class Post < ApplicationRecord
    belongs_to :playground
    belongs_to :user
    has_many :post_comments, dependent: :destroy
    has_many_attached :post_images

    validates :title, presence: true, length: { maximum: 50 }
    validates :body, presence: true, length: { maximum: 300 }
    validate :image_count_within_limit

    def get_post_image(width, height)
      unless post_image.attached?

        file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
        post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      post_image.variant(resize_to_limit: [width, height]).processed

    end

    private

    def image_count_within_limit
      if post_images.attached? && post_images.count > 8
        errors.add(:post_images, "は合計8枚までしか保存できません。")
      end

    end

    def self.looks(search, word)
      if search == "perfect_match"
        @posts = Post.where("title LIKE ? OR body LIKE ?", "#{word}", "#{word}").where(is_displayed: true).order(created_at: :desc)
      elsif search == "forward_match"
        @posts = Post.where("title LIKE ? OR body LIKE ?", "#{word}%", "#{word}%").where(is_displayed: true).order(created_at: :desc)
      elsif search == "backward_match"
        @posts = Post.where("title LIKE ? OR body LIKE ?", "%#{word}", "%#{word}").where(is_displayed: true).order(created_at: :desc)
      elsif search == "partial_match"
        @posts = Post.where("title LIKE ? OR body LIKE ?", "%#{word}%", "%#{word}%").where(is_displayed: true).order(created_at: :desc)
      else
        @posts = Post.where(is_displayed: true).order(created_at: :desc)
      end
    end

end
