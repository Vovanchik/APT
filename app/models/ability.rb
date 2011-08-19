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
      can :read, Forum
      can [:create, :destroy, :read],  Job
      can :update, Job do |job|
        job.handlers.include?(user) || job.author == user
      end

      cannot :add_users_to_forum
    end
  end
end