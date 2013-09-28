ActiveAdmin.register Comment do
  index do
    column :author_name do |comment|
      comment.author_name.present? ? comment.author_name : link_to(comment.user.name, admin_comment_path(comment))
    end
    column :post, 'Статья' do |comment|
      link_to comment.post.heading, admin_post_path(comment.post)
    end
    default_actions
  end

  show do
    h2 link_to comment.post.heading, admin_comment_path(comment)
    h5 comment.author_name.present? ? comment.author_name : link_to(comment.user.name, admin_comment_path(comment))
    div I18n::l comment.created_at
    div comment.content.html_safe
  end

  filter :content
  filter :created_at
  filter :updated_at
end
