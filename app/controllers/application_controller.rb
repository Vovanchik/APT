class ApplicationController < ActionController::Base
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

  def find_received_users (users)
    found_users = Array.new()

    users.each do |user|
      new_user = User.find_by_nick(user)
      if new_user.nil?
        flash_message :error, "User #{user} is not defined in DB"
      else
        found_users ||=[]
        found_users << new_user
      end
    end
    return found_users
  end

    def find_not_registered_users (users)
    found_users = Array.new()

    users.each do |user|
      new_user = User.find_by_nick(user)
      if new_user.nil?
        found_users << user
      end
    end
    return found_users
  end

  def find_menu_data
    @forum_free = Forum.find_by_name(:free)
    @forum_private = Forum.find_by_name(:private)
    @users_all = User.find(:all)
  end

end
