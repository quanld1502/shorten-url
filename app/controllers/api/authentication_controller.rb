class Api::AuthenticationController < Api::BaseController
  def login
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      render json: { token: sign_in(user), user: user, message: I18n.t('success.messages.sign_in') }, status: :ok
    else
      render json: { message: 'Login failed' }, status: :unprocessable_entity
    end
  end
end