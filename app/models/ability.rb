# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.has_role? :admin
        can :manage, :all

       elsif user.has_role? :customer
        can :update, Order do |order|
            order.user == user
        end
        can :destroy, Order do |order|
            order.user == user
        end
        
        
        can :update, Comment do |comment|
            comment.user == user
        end
        can :destroy, comment do |comment|
            comment.user == user
        end
        

        can :update, Review do |review|
            review.user == user
        end
        can :destroy, Review do |review|
            review.user == user
        end

        can :manage, Comment
        can :manage, User, user_id: user.id
        can :read, Customer, user_id: user.id
        can :manage, Order
        can :manage, Review
        cannot :read, seller
        cannot :read, Admin

      elsif user.has_role? :seller

        can :manage, Product

        can :destroy, Order do |order|
          order.user == user
        end

        
        can :manage, User, user_id: user.id
        cannot :read, Admin
        cannot :read, Customer



      else  
         can :read, :all
      end
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
