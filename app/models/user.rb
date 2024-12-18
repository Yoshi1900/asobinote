class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :playgrounds, dependent: :nullify
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy 
  has_one_attached :avatar_image

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :encrypted_password, presence: true
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :introduction, presence: true, length: { maximum: 300 }
  validates :phone_number, presence: true, uniqueness: true,format: { with: /\A\d{10,11}\z/ }
  validate :validate_avatar_image

  
  def get_avatar_image(width, height)
    unless avatar_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      avatar_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    avatar_image.variant(resize_to_limit: [width, height]).processed
  end
 


  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "guestuser"
      user.introduction = "This is a guest user introduction." # 300文字以内に収める
      user.phone_number = "0000000000" # 一意性とフォーマットを満たす
    end
  end
    
  def guest_user?
    email == GUEST_USER_EMAIL
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("nickname LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("nickname LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("nickname LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("nickname LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  def validate_avatar_image
    return unless avatar_image.attached?

    # 画像サイズの制限（1MB以下）
    if avatar_image.byte_size > 1.megabyte
      errors.add(:avatar_image, "は1MB以下にしてください")
    end

    # 画像形式の制限（オプション）
    acceptable_types = ["image/jpeg", "image/png", "image/gif"]
    unless acceptable_types.include?(avatar_image.content_type)
      errors.add(:avatar_image, "はJPEG, PNG, またはGIF形式でなければなりません")
    end
  end

end
