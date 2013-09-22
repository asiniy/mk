class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :users

  validates :title,
    presence: true,
    uniqueness: true
end
