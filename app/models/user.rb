# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  ADMIN_ROLE = 'ADMIN'
  SYSTEM_ROLE = 'SYSTEM'
  USER_ROLE = 'USER'

  scope :user_role, -> { where( role: USER_ROLE ) }

  # Avatar
  has_attached_file :avatar,
                    styles: {
                      medium: '300x300>',
                      thumb: '100x100>'
                    },
                    convert_options: { original: '-strip', medium: '-strip', thumb: '-strip' },
                    default_url: '/assets/empty_avatar.png'

  validates_attachment_content_type :avatar, content_type: %r{\Aimage/.*\z}

  has_many :locations, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :reservations, dependent: :destroy

  has_many :notifications,
           class_name: 'SentNotification',
           foreign_key: 'target_user_id',
           dependent: :destroy

  # force set admin role
  after_find do |user|
    user.role = ADMIN_ROLE if user.email == ENV['admin_role1']
    user.role = ADMIN_ROLE if user.email == ENV['admin_role2']
  end

  before_create do
    self.role ||= USER_ROLE
    logger.debug "* Set users locale to '#{I18n.locale}'"
    self.language_id = I18n.locale
  end

  def active_locations
    locations.activated
  end

  def inactive_locations
    locations.inactive
  end

  def isAdmin
    role == ADMIN_ROLE
  end

  def system_user?
    # system user can not log in  are used as a placeholder for incomming messages with reservations
    role == SYSTEM_ROLE
  end

  def self.system_user
    @system_user ||= find_system_user
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def fullname?
    first_name? || last_name?
  end

  def confirmed?
    !confirmed_at.nil?
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

  def premium?
    true
  end

  # Phone verification
  def generate_pin
    self.pin = SecureRandom.hex(2)
    self.phone_verified = false
    save
  end

  def send_pin(text)
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: ENV['twilio_from_phone'],
      to: phone_number,
      body: text + pin
    )
  end

  def verify_pin(entered_pin)
    update(phone_verified: true) if pin == entered_pin
  end

  def self.find_system_user
    user = User.find_or_create_by(first_name: 'System',
                                  last_name: 'User',
                                  email: 'system@example.com',
                                  role: SYSTEM_ROLE)
    if user.confirmed_at.nil?
      user.password = SecureRandom.hex(16)
      user.confirmed_at = Date.today
      user.save
    end
    user
  end
end
