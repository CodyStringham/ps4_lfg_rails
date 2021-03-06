class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json

  skip_before_action :authenticate_user_from_token!
  skip_before_action :authenticate_user!

  def user_login
    if @user = User.find_by_email(user_params[:email])
      if @user.valid_password?(user_params[:password])
        sign_in(@user, store: false)
        render 'api/v1/users/show'
      else
        @message = {error: 'Unauthorized.'}
        render 'api/v1/error'
      end
    else
      @message = {error: 'Unauthorized.'}
      render 'api/v1/error'
    end
  end

  def user_register
    @user = User.new(user_params.merge(auth_token: Devise.friendly_token))
    if @user.save
      sign_in(@user, store: false)
      render 'api/v1/users/show'
    else
      errors = @user.errors.full_messages.join(". ")
      @message = {error: errors}
      render 'api/v1/error'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :gamertag, :mic, :region, :language)
  end

end
