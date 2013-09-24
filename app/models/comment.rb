class Comment < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :user
  belongs_to :post

  validates :content,
    presence: true
end
