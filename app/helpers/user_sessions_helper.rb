module UserSessionsHelper
  def store_location
    session[:return_to] = request.fullpath
  end
end
