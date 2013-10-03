module Mailable
  extend ActiveSupport::Concern

  included do
    after_save -> {
      if published_changed?
        if published
          UserMailer.delay.post_published(id)

          User # subscriptions
            .uniq.joins(:categories).where(categories: { id: category_ids })
            .where.not(id: user_id).each do |user|
              user_category_ids = category_ids & user.category_ids
              UserMailer.delay.category_subscription(user.id, id, user_category_ids)
            end
        elsif published == false
          UserMailer.delay.post_declined(id)
        end
      end
    }
  end
end
