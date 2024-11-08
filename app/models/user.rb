class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :playgrounds, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy 
  has_one_attached :avatar_image

  
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
    end
  end
    
  def guest_user?
    email == GUEST_USER_EMAIL
  end

end
