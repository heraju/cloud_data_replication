module ApplicationHelper
  def current_server
    session[:server_id] = Node.first.id unless session[:server_id]
    @current_server = Node.find(session[:server_id])
  end
end
