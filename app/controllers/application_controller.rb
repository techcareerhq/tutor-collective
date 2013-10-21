class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private
  def current_user
    @current_user ||= Tutor.find(session[:tutor_id]) if session[:tutor_id]
  rescue ActiveRecord::RecordNotFound
      session[:tutor_id] = nil
  end

end
