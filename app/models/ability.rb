class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :super_user
      can :assign_roles
      can :add_users_to_forum
      can :manage, :all
    elsif user.role? :user
      can :update, User do |resource|
        resource == user
      end
      can :read, Forum do |forum|
        forum.users.include?(user)
      end
      can [:create, :destroy],  Job
      can [:update], Job do |job|
        job.handlers.include?(user) || job.author == user
      end
      can [:read], Job do |job|
        job.handlers.include?(user) || job.author == user || job.forum.users.include?(user)
      end

      cannot :add_users_to_forum
    end
  end
end