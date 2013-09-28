ActiveAdmin.register Category do
  index do
    column :title
    column 'Количество опубликованных статей' do |category|
      link_to category.posts.published.count, admin_posts_path('q[categories_id_eq]' => category.id)
    end
    default_actions
  end

  controller do
    def permitted_params
      params.permit(category: [:title])
    end
  end

  filter :title
end
