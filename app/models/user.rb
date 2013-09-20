class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :token_authenticatable, :lockable

  scope :registered_today, -> { where('"users"."created_at" > ?', Time.zone.now.beginning_of_day) }

  validates :name,
    presence: true

  before_save -> {
    self.admin = true if User.count == 0
  }

  has_many :posts
end
