class EventsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  skip_before_action :require_event, only: [:index]

  def show
    if current_event.nil?
      return redirect_to root_path
    end
  end

  def index
  end

end
