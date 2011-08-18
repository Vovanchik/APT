module ApplicationHelper
  def users_registered
    @users_all.map{|user| user.nick.to_s.eql?('admin') ? nil : user.nick}.join(' ') if !@users_all.nil?
  end

  def users_assigned_to_forum(forum)
    forum.users.map{|user| user.nick.to_s.eql?('admin') ? nil : user.nick}.join(' ') if !@forum.users.nil?
  end
end
