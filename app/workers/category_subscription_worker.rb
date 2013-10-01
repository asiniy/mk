class CategorySubscriptionWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find(post_id)
    category_ids = post.category_ids

    User
      .uniq
      .joins('INNER JOIN "categories_users" ON "users"."id" = "categories_users"."user_id"')
      .where('"categories_users"."category_id" in (?)', category_ids)
      .where('"users"."id" != ?', post.user_id)
      .each do |user|
        user_category_ids = category_ids & user.category_ids
        UserMailer.category_subscription(user.id, post_id, user_category_ids).deliver
      end
  end
end
