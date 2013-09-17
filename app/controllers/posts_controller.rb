class PostsController < InheritedResources::Base
  before_filter :only_user!, only: [ :new, :create ]
  actions :all, except: [ :edit, :update, :destroy ]
  respond_to :html

  protected
  def permitted_params
    params.permit(post: [ :heading, :short_description, :body ])
  end
end
