ActiveAdmin.register Category do
  index do
    column :title
    default_actions
  end

  controller do
    def permitted_params
      params.permit(category: [:title])
    end
  end
end
