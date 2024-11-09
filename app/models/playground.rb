class Playground < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :posts, dependent: :destroy
  belongs_to :user
  has_many_attached :playground_images

  # 仮想属性として tag_list を定義
  attr_accessor :tag_list

  # バリデーション
  validate :image_count_within_limit

  # タグの保存処理を after_save で実行
  after_save :save_tags_from_list

  # 画像のリサイズメソッド
  def get_playground_image(width, height)
    unless playground_images.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      playground_images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    playground_images.first.variant(resize_to_limit: [width, height]).processed
  end

  # 画像の枚数制限のバリデーション
  def image_count_within_limit
    if playground_images.attached? && playground_images.count > 8
      errors.add(:playground_images, "は合計8枚までしかアップロードできません。")
    end
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @playgrounds = Playground.where("name LIKE ? OR description LIKE ? OR address LIKE ?", "#{word}", "#{word}", "#{word}").order(created_at: :desc)
    elsif search == "forward_match"
      @playgrounds = Playground.where("name LIKE ? OR description LIKE ? OR address LIKE ?", "#{word}%", "#{word}%", "#{word}%").order(created_at: :desc)
    elsif search == "backward_match"
      @playgrounds = Playground.where("name LIKE ? OR description LIKE ? OR address LIKE ?", "%#{word}", "%#{word}", "%#{word}").order(created_at: :desc)
    elsif search == "partial_match"
      @playgrounds = Playground.where("name LIKE ? OR description LIKE ? OR address LIKE ?", "%#{word}%", "%#{word}%", "%#{word}%").order(created_at: :desc)
    else
      @playgrounds = Playground.order(created_at: :desc)
    end
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
      tag = Tag.find_or_create_by(name: new_tag)
      self.tags << tag unless self.tags.exists?(name: new_tag)
    end
  end
  
end