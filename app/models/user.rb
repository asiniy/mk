class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable,
         :token_authenticatable, :lockable

  validates :name,
    presence: true

  before_validation -> {
    self.admin = true if User.count == 0
  }
end
