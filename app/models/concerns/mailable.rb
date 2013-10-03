module Mailable
  extend ActiveSupport::Concern

  included do
    after_save -> {
      if published_changed?
        if published
          UserMailer.post_published(id).deliver

          User # subscriptions
            .uniq.joins(:categories).where(categories: { id: category_ids })
            .where.not(id: user_id).each do |user|
              user_category_ids = category_ids & user.category_ids
              UserMailer.category_subscription(user.id, id, user_category_ids).deliver
            end
        elsif published == false
          UserMailer.post_declined(id).deliver
        end
      end
    }
  end
end
