class Ability
  include CanCan::Ability

  def initialize(user)
    if user.respond_to? :role
        can :manage, :responsible if user.role.id == 1
        can :manage, :tcc1 if user.role.id == 1 || user.role.id == 2
        can :manage, :teacher if user.role.id == 1 || user.role.id == 3
    else
        can :manage, :student
    end
  end
end
