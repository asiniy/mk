ActiveAdmin.register ActsAsTaggableOn::Tag, as: "Tag" do
  index do
    column 'Название' do |tag|
      tag.name
    end
    column 'Связанные статьи' do |tag|
      Post.tagged_with(tag.name).count
    end
    default_actions
  end

  show do
    attributes_table do
      row 'Название' do |tag|
        tag.name
      end
      row 'Связанные статьи' do |tag|
        ul do
          Post.tagged_with(tag.name).each do |post|
            li link_to post.heading, admin_post_path(post)
          end
        end
      end
    end
    active_admin_comments
  end

  controller do
    def permitted_params
      params.permit(tag: [:name])
    end
  end

  filter :name, label: 'Название'
end
