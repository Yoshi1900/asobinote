class Post < ApplicationRecord
    belongs_to :playground
    belongs_to :user
    has_many :post_comments, dependent: :destroy
    has_many_attached :post_images
    has_many :post_taggings, dependent: :destroy
    has_many :tags, through: :post_taggings
    
    validates :title, presence: true, length: { maximum: 50 }
    validates :body, presence: true, length: { maximum: 300 }
    validate :image_count_within_limit

    # 仮想属性として tag_list を定義
    attr_accessor :tag_list

    # タグの保存処理を after_save で実行
    after_save :save_tags_from_list


    def get_post_image(width, height)
      unless post_image.attached?

        file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
        post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      post_image.variant(resize_to_limit: [width, height]).processed

    end

    def combined_images(new_images)
      # 既存の画像を取得し、新しい画像と結合
      existing_images = post_images.blobs
      # existing_images = post_images.attachments # 現在の画像データを取得
      combined = existing_images + Array(new_images) # 配列に変換し、新しい画像と結合
      # 合計枚数が8枚を超えている場合、nilを返す
      if combined.size > 8
        errors.add(:post_images, "は合計8枚までしか保存できません。")
        return nil
      end
      combined
    end


    def save_tags_from_list
      return unless tag_list.present?
    
      # タグをカンマやスペースで分割し、前後の空白を取り除いた配列を取得
      tag_names = tag_list.split(/[,\s;:#\u3000\uFF1A\uFF0C\uFF03]+/).map(&:strip).uniq

      # 現在のタグ名のリストを取得
      current_tags = self.tags.pluck(:name)
      old_tags = current_tags - tag_names
      new_tags = tag_names - current_tags
    
      # 古いタグの削除
      old_tags.each do |old_tag|
        tag = self.tags.find_by(name: old_tag)
        self.tags.delete(tag) if tag.present?
      end
    
      # 新しいタグの追加
      new_tags.each do |new_tag|
        tag = Tag.find_or_create_by(name: new_tag) # 既存のタグを検索し、存在しない場合のみ作成
        self.tags << tag unless self.tags.exists?(name: new_tag) # 重複を避けて関連に追加
      end
    end
  
    def update_tags(tag_names)
      # タグの重複を排除
      tag_names = tag_names.uniq
    
      # 現在のタグ名のリストを取得
      current_tags = self.tags.pluck(:name)
      old_tags = current_tags - tag_names
      new_tags = tag_names - current_tags
    
      # 古いタグの削除
      old_tags.each do |old_tag|
        tag = self.tags.find_by(name: old_tag)
        self.tags.delete(tag) if tag.present?
      end
    
      # 新しいタグの追加
      new_tags.each do |new_tag|
        tag = Tag.find_or_create_by(name: new_tag)
        self.tags << tag unless self.tags.exists?(name: new_tag)
      end
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
