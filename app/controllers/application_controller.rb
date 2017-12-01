class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_event, :require_login
  helper_method :current_user, :event_params, :event_name

  def current_user
    current_event && current_event.users.find_by_id(session[current_event.id])
  end

  def require_event
    if current_event.nil?
      redirect_to root_path
    end
  end

  def require_login
    if current_user.nil?
      redirect_to login_path(event_params)
    end
  end

  def current_event
    Event.find_by_name(event_name)
  end

  def event_name
    params[:event]
  end

  def event_params
    { event: params.require(:event) }
  end


end
