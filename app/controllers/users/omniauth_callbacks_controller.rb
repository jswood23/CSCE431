# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # google action method
  def google_oauth2
    user = User.from_omniauth(auth)
    info = Information.find_by(uid: user.id)
    unless info
      new_info = Information.create!(uid: user.id)
      new_info.save!
    end
    if user.present?
      sign_out_all_scopes
      flash[:success] = t('devise.omniauth_callbacks.success', kind: 'Google')
      sign_in(user, event: :authentication)
      redirect_to('/users/edit')
    else
      flash[:alert] = t('devise.omniauth_callbacks.failure', reason: "#{auth.info.email} is not authorized")
      redirect_to('/')
    end
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
