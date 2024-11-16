class Playground < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings


  belongs_to :user, optional: true
  has_many_attached :playground_images

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :post_code, presence: true, format: { with: /\A\d{7}\z/, message: "はハイフンなしの7文字の数字で入力してください" }
  validates :phone_number, presence: true, uniqueness: true,format: { with: /\A\d{10,11}\z/, message: "はハイフンなしの10～11文字の数字で入力してください"  }
  validate :validate_playground_images

  geocoded_by :address
  after_validation :geocode


  # 仮想属性として tag_list を定義
  attr_accessor :tag_list

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

  def combined_images(new_images)
    # 既存の画像を取得し、新しい画像と結合
    existing_images = playground_images.blobs# 現在の画像データを取得
    combined = existing_images + Array(new_images) # 配列に変換し、新しい画像と結合
    # 合計枚数が8枚を超えている場合、nilを返す
    if combined.size > 8
      errors.add(:playground_images, "は合計8枚までしか保存できません。")
      return nil
    end
    combined
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
    return unless tag_names.present?
    # タグの重複を排除
    tag_names = tag_names.split(",") if tag_names.is_a?(String)
    tag_names = tag_names.map(&:strip).uniq
  
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
  
  # postから追加のタグを登録する
  def post_update_tags(tag_names)
    return unless tag_names.present?
    # タグの重複を排除
    tag_names = tag_names.split(",") if tag_names.is_a?(String)
    tag_names = tag_names.map(&:strip).uniq
  
    # 現在のタグと元々のタグを合わせる
    current_tags = self.tags.pluck(:name)
    new_tags = tag_names + current_tags
  
    # 合わせたタグの追加
    new_tags.each do |new_tag|
      tag = Tag.find_or_create_by(name: new_tag)
      self.tags << tag unless self.tags.exists?(name: new_tag)
    end
  end

  private

  def validate_playground_images
    # 最大8枚までの制限
    if playground_images.count > 8
      errors.add(:playground_images, "画像は合計で8枚までアップロード可能です")
    end

    # 各画像のサイズ制限 (1MB = 1,048,576 bytes)
    playground_images.each do |image|
      if image.byte_size > 1.megabyte
        errors.add(:playground_images, "各画像のサイズは1MB以下にしてください")
      end
    end
  end


end