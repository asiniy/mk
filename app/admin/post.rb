ActiveAdmin.register Post do
  scope 'Отклонённые', :declined
  scope 'Опубликованные', :published
  scope 'Непроверенные', :unchecked

  index do
    column :heading
    bool_column :published
    default_actions
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
      f.input :published
    end
    f.inputs "Содержимое" do
      f.input :body, input_html: { class: 'redactor' }
    end
    f.inputs  do
      f.actions
    end
  end
end
