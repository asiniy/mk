class Post < ActiveRecord::Base
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  belongs_to :user
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories

  validates :heading,
    presence: true

  validates :short_description,
    presence: true

  validates :body,
    presence: true

  validates :published,
    inclusion: [true, false]

  validates :user_id,
    presence: true

  validates :categories,
    has_categories: true

  after_save -> {
    PostPublishedWorker.perform_async(id) if published && !changed_attributes['published']
  }
end
