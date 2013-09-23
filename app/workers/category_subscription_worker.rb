class CategorySubscriptionWorker
  include Sidekiq::Worker

  def perform(post_id)
    category_ids = Post.find(post_id).category_ids

    User
      .uniq
      .joins('INNER JOIN "categories_users" ON "users"."id" = "categories_users"."user_id"')
      .where('"categories_users"."category_id" in (?)', category_ids)
      .each do |user|
        user_category_ids = category_ids & user.category_ids
        UserMailer.category_subscription(user.id, post_id, user_category_ids).deliver
      end
  end
end
