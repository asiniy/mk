class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :token_authenticatable, :lockable, :omniauthable

  scope :registered_today, -> { where('"users"."created_at" > ?', Time.zone.now.beginning_of_day) }

  has_many :posts
  has_many :comments
  has_and_belongs_to_many :categories

  validates :name,
    presence: true

  validates :email,
    email: true,
    if: 'email.present?'

  before_save -> {
    self.admin = true if User.count == 0
  }
end
