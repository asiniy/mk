ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Пользователи, зарегестрированные сегодня: #{User.registered_today.length}" do
          h3 { link_to "Смотреть всех #{User.count} пользователей", admin_users_path }
          ul do
            User.registered_today.each do |user|
              li link_to user.name, admin_user_path(user)
            end
          end
        end
      end

      column do
        panel "Статьи (всего #{link_to Post.count, admin_posts_path})".html_safe do
          ul do
            Post.order('created_at DESC').last(10).each do |post|
              li link_to post.heading, admin_post_path(post)
            end
          end
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
