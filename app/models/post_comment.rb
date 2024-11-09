class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, presence: true

  def self.looks(search, word)
    if search == "perfect_match"
      @post_comments = PostComment.where("comment LIKE ?", "#{word}").order(created_at: :desc)
    elsif search == "forward_match"
      @post_comments = PostComment.where("comment LIKE ?", "#{word}%").order(created_at: :desc)
    elsif search == "backward_match"
      @post_comments = PostComment.where("comment LIKE ?", "%#{word}").order(created_at: :desc)
    elsif search == "partial_match"
      @post_comments = PostComment.where("comment LIKE ?", "%#{word}%").order(created_at: :desc)
    else
      @post_comments = PostComment.order(created_at: :desc)
    end
  end
  
end
