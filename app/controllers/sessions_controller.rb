class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username])

    if @user && @user.authenticate(params[:user][:password])
      @session = Session.create(user_id: @user.id, token: SecureRandom.hex)
      cookies.permanent[:twitter_session_token] = { value: @session.token, httponly: true }
      render json: { success: true }, status: :created
    else
      render json: { error: 'Invalid username or password' }, status: :unprocessable_entity
    end
  end

  def authenticated
    @session = Session.find_by(token: cookies.signed[:twitter_session_token])
    if @session
      user = @session.user
      render json: {
        authenticated: true,
        username: user.username
      }, status: :ok
    else
      render json: { authenticated: false }, status: :ok
    end
  end

  def destroy
    @session = Session.find_by(token: cookies.signed[:twitter_session_token])
    if @session
      @session.destroy
      cookies.delete(:twitter_session_token)
      head :no_content
    else
      render json: { error: 'Session not found' }, status: :not_found
    end
  end
end
