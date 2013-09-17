class Post < ActiveRecord::Base
  validates :heading,
    presence: true

  validates :short_description,
    presence: true

  validates :body,
    presence: true

  validates :published,
    presence: true

  validates :user_id,
    presence: true
end
