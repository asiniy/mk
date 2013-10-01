class PostPublishedStatusWorker
  include Sidekiq::Worker

  def perform(post_id, published)
    if published
      UserMailer.post_published(post_id).deliver
    elsif published == false
      UserMailer.post_declined(post_id).deliver
    end
  end
end
