class Post < ActiveRecord::Base
  acts_as_taggable

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
    if [true, false].include?(published) # work with that
      PostPublishedStatusWorker.perform_async(id, published) # sending email if post published/declined
      CategorySubscriptionWorker.perform_async(id) if published # sending email for category subscriptions
    end
  }

  def body= value
    value = ActionController::Base.helpers.sanitize(value, tags: %w[p h3 strong del em iframe img]) if value.is_a?(String)
    super value
  end
end
