class ProfilesController < ApplicationController
  before_filter :only_user!

  def show ; end

  def update
    current_user.update_attributes(profile_params)
    redirect_to profile_path
  end

  protected
  def profile_params
    params.require(:user).permit({category_ids: []})
  end
end
