class PostPublishedWorker
  include Sidekiq::Worker

  def perform(post_id)
    UserMailer.post_published(post_id).deliver
  end
end
