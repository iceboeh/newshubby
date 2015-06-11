class Ability
  include CanCan::Ability

  def initialize(newsroom)

    newsroom ||= Newsroom.new # guest user (not logged in)
    #can :manage, :all

    if newsroom.admin?
      can :manage, :all
    else
      can :read, :all

      can :manage, Newsroom, id: newsroom.id

      can :manage, PressRelease, newsroom_id: newsroom.id

      can :manage, Funding, newsroom_id: newsroom.id

      can :manage, Person, newsroom_id: newsroom.id

      can :manage, Subscription, newsroom_id: newsroom.id

      can :manage, Link, newsroom_id: newsroom.id

      can :manage, Upload, newsroom_id: newsroom.id

      can :manage, PressreleaseType, newsroom_id: newsroom.id
      
      can :manage, Distribution, newsroom_id: newsroom.id
      
      #can :read, Distribution do |distribution|
       # distribution.press_release.newsroom.where("newsroom.id = ?", newsroom.id).any?
        #end

    end
    
    
    
      #can :crud, Subscription do |subscription|
       # subscription.try(:user) == user
      #end      
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
