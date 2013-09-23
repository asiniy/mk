class User < ActiveRecord::Base
  include TheCommentsUser

  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :token_authenticatable, :lockable

  scope :registered_today, -> { where('"users"."created_at" > ?', Time.zone.now.beginning_of_day) }

  has_many :posts
  has_and_belongs_to_many :categories

  validates :name,
    presence: true

  before_save -> {
    self.admin = true if User.count == 0
  }

  # TheComments methods
  def comment_moderator? comment
    admin?
  end
end
