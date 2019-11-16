class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :access, :rails_admin
      can :read, :all
      can :read, :dashboard
    end
  end
end
