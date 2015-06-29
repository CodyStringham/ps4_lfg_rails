class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json


  def login
    if @user = User.find_by(user_auth_params)
      render 'api/v1/users/show'
    else
      @message = {error: 'Unauthorized.'}
      render 'api/v1/error'
    end
  end

  def register
    @user = User.new(user_params.merge(auth_token: Devise.friendly_token))
    if @user.save
      render 'api/v1/users/show'
    else
      errors = @user.errors.full_messages.join(". ")
      @message = {error: errors}
      render 'api/v1/error'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :gamertag, :mic, :region, :language)
  end

  def user_auth_params
    params.require(:user).permit(:auth_token)
  end

end
