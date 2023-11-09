class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :update, Post do |post|
        post.author == user
      end
      can :destroy, Post do |post|
        post.author == user
      end
      can :update, Comment do |comment|
        comment.user == user
      end
      can :destroy, Comment do |comment|
        comment.user == user
      end
      can :create, Post
      can :create, Comment
      can :read, :all
    end
  end
end
