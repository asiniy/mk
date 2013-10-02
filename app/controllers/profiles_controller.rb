class ProfilesController < ApplicationController
  before_filter :only_user!

  def show ; end

  def update
    current_user.category_ids = params[:user][:category_ids]
    redirect_to profile_path
  end
end
