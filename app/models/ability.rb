class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= current_user
    can :manage, Content, user_id: user.id
    can :read, Content
  end
end
