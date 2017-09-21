class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_server
    session[:server_id] = Node.first.id unless session[:server_id]
    @current_server = Node.find(session[:server_id])
  end
end
