class Post < ActiveRecord::Base
  scope :published, -> { where(published: true) }
  scope :declined, -> { where(published: false) }
  scope :unchecked, -> { where(published: nil) }

  belongs_to :user
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories

  validates :heading,
    presence: true

  validates :short_description,
    presence: true

  validates :body,
    presence: true

  validates :user_id,
    presence: true

  validates :categories,
    has_categories: true

  after_save -> {
    PostPublishedStatusWorker.perform_async(id, published) if [true, false].include?(published)
  }
end
