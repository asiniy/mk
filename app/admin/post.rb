ActiveAdmin.register Post do
  scope 'Отклонённые', :declined
  scope 'Опубликованные', :published
  scope 'Непроверенные', :unchecked

  index do
    column :heading
    bool_column :published
    column 'Автор' do |post|
      link_to(post.user.name, admin_user_path(post.user))
    end
    default_actions
  end

  show do
    attributes_table do
      row :heading
      row :short_description
      row :body do |post|
        post.body.html_safe
      end
      bool_row :published
      row :user
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  controller do
    def permitted_params
      params.permit(post: [:heading, :short_description, :body, :published])
    end
  end

  form do |f|
    f.inputs "Редактировать статью" do
      f.input :heading
      f.input :short_description
      f.input :published, as: :select
    end
    f.inputs "Содержимое" do
      f.input :body, input_html: { class: 'redactor' }
    end
    f.inputs  do
      f.actions
    end
  end

  filter :heading
  filter :short_description
  filter :content
  filter :published
  filter :user
  filter :categories
  filter :created_at
  filter :updated_at
end
