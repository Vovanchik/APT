class ApplicationController < ActionController::Base
  check_authorization

  protect_from_forgery

  helper_method :current_user, :current_user_session

  before_filter :find_menu_data
  
  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
  end

  def registered_users (users)
    found_users = Array.new()
    users.each do |user|
      new_user = User.find_by_nick(user)
      found_users << new_user unless new_user.nil?
    end
    return found_users
  end

  def not_assigned_users?(users, parent_object, error_object)
    users.each{
      |handler|
        error_object.errors.add(handler.nick, "is not assigned to forum") unless handler.assigned_to? parent_object
    }
    return error_object.errors.count !=0
  end

  def not_registered_users?(users, object)
    users.each{
      |user|
        object.errors.add(user, "is not registered") if User.find_by_nick(user).nil?
    }
    return object.errors.count !=0
  end

  def find_menu_data
    @forum_free = Forum.find_by_name(:free)
    @forum_private = Forum.find_by_name(:private)
    @users_all = User.find(:all)
  end

 rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to :login
    else
      flash[:access_denied] = "You are not authorized to do this!!!"
      redirect_to root_url
    end
  end

end
