class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    ohash = {
      twitter_uid: request.env['omniauth.auth']['credentials']['token'],
      twitter_token: request.env['omniauth.auth']['credentials']['secret'],
      twitter_name: request.env['omniauth.auth']['info']['name']
    }

    if user_signed_in?
      current_user.update_attributes(ohash)
      redirect_to profile_path
    else
      @user = User.find_by_twitter_uid_and_twitter_token(ohash[:twitter_uid], ohash[:twitter_token])

      if @user.present?
        sign_in @user
        redirect_to root_path, success: 'Вы успешно вошли!'
      else
        session[:ohash] = ohash
        redirect_to new_user_registration_path, notice: 'Необходим email для регистрации'
      end
    end
  end
end
