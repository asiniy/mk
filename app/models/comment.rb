class Comment < ActiveRecord::Base
  acts_as_nested_set

  belongs_to :user
  belongs_to :post

  validates :author_name,
    presence: true,
    if: 'user_id.blank?'

  validates :content,
    presence: true

  def content= value
    value = ActionController::Base.helpers.sanitize(value, tags: %w[p h3 strong del em iframe img]) if value.is_a?(String)
    super value
  end
end
