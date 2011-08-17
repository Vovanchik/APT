class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user

    if user.role? :super_user
      can :assign_roles
      can :manage, :all
    elsif user.role? :user
      can :update, User do |resource|
        resource == user
      end
    end
  end
end