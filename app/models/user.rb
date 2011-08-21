class User < ActiveRecord::Base
  has_and_belongs_to_many :forums

  has_and_belongs_to_many :jobs,
    :class_name => "Job",
    :join_table => "jobs_handlers",
    :uniq => true

  belongs_to :role

  acts_as_authentic do |c|
    c.login_field = :nick
  end

  def assigned_to?(forum)
    unless self.forums.nil?
      return self.forums.include?(forum)
    end
  end

  def role?(role)
    unless self.role.nil?
      return self.role.name == role.to_s
    end
  end

  def admin?
    return self.nick == 'admin'
  end
  
end
