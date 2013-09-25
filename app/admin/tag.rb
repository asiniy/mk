ActiveAdmin.register ActsAsTaggableOn::Tag, as: "Tag" do
  show do
    h2 tag.name
    h4 "Связанные статьи"
    ul do
      tag.taggings.each do |post|
        li link_to(Post.find(post.taggable_id).heading, admin_post_path(post.taggable_id))
      end
    end
  end

  controller do
    def permitted_params
      params.permit(tag: [:name])
    end
  end
end
