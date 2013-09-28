ActiveAdmin.register Comment do
  index do
    column 'Автор' do |comment|
      comment.author_name.present? ? comment.author_name : link_to(comment.user.name, admin_user_path(comment.user))
    end
    column 'Статья' do |comment|
      link_to comment.post.heading, admin_post_path(comment.post)
    end
    default_actions
  end

  show do
    attributes_table do
      row 'Статья' do |comment|
        link_to comment.post.heading, admin_comment_path(comment)
      end
      row 'Автор' do |comment|
        comment.author_name.present? ? comment.author_name : link_to(comment.user.name, admin_user_path(comment.user))
      end
      row :created_at
      row 'Содержимое' do |comment|
        comment.content.html_safe
      end
    end
    active_admin_comments
  end

  filter :content
  filter :created_at
  filter :updated_at
end
