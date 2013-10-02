class ProfilesController < ApplicationController
  before_filter :only_user!

  def show ; end

  def update
    current_user.category_ids = params[:category_ids]
    render :show
  end
end
