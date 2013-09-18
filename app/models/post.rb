class Post < ActiveRecord::Base
  scope :published, -> { where(published: true) }

  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories

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

  validates :categories,
    has_categories: true
end
