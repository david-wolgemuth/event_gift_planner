class UsersController < ApplicationController
  skip_before_action :require_login, only: [:login, :authenticate]

  def login
    if current_user.present?
      redirect_to wishlist_path(event_params)
    end
  end

  def authenticate
    user = User.find_by_username(user_params[:username])
    unless user.present? &&
           user.authenticate(user_params[:password]) &&
           user.event == current_event
      return redirect_to login_path(event_params)
    end
    session[current_event.id] = user.id
    redirect_to wishlist_path(event_params)
  end

  def logout
    session[current_event.id] = nil
    redirect_to login_path(event_params)
  end

private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end