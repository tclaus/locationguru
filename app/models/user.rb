class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

# Avatar
  has_attached_file :avatar, {
    styles: {
      medium: "300x300>",
      thumb: "100x100>"
      },
      convert_options: {original: "-strip", medium: "-strip", thumb: "-strip"},
      url: "users/:hash.:extension",
      hash_secret: "5cc92b152f1de28ba2cf25ec4432f00f488b055395fa8a9af162174017473e15878abac104c8cef7f50c7eb213e048bd02cbad131440fa9fc422a30b86d4deb7",
    default_url: "/assets/empty_avatar.png"
  }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  # validates :fullname, presence: true, length: { maximum: 50 }

  has_many :locations
  has_many :reservations
  has_many :guest_reviews, class_name: "GuestReview", foreign_key: "guest_id"
  has_many :host_reviews, class_name: "HostReview", foreign_key: "host_id"

  # force set admin role
   after_find do |user|
     user.role = "admin" if user.email == ENV['admin_role1']
     user.role = "admin" if user.email == ENV['admin_role2']
   end

 def activeLocations
   locations.where('active = true')
 end

 def inactiveLocations
   locations.where('active = false')
 end

def isAdmin
   if self.role == "admin"
     return true
  else
    return false
  end
end

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    if user
      return user
    else

      where(provider: auth.provider, uid: auth.uid).first_or_create do |auth_user|
        auth_user.email = auth.info.email
        auth_user.password = Devise.friendly_token[0, 20]
        auth_user.fullname = auth.info.name # assuming the user model has a name
        auth_user.image = auth.info.image # assuming the user model has an image
        auth_user.uid = auth.uid
        auth_user.provider = auth.provider

        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        auth_user.skip_confirmation!
      end
    end
  end

end
