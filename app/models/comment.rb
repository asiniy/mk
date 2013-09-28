class Comment < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :user
  belongs_to :post

  validates :author_name,
    presence: true,
    if: 'user_id.blank?'

  validates :content,
    presence: true
end
