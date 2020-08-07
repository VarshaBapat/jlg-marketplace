# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
       user ||= User.new # guest user (not logged in)
       if user.admin?
        can :manage, :all

       elsif user.customer?
        can :manage, User, user_id: user.id 
        can :manage, Order, customer_id: user.customer.id 
        can :read, Customer, user_id: user.id 
        can :read, Product, customer_id: user.customer.id 
        cannot :read, Seller
        cannot :read, Admin 

      elsif user.seller?
        can :manage, User, user_id: user.id 
        can :manage, Product, seller_id: user.seller.id
        can :read, Order, seller_id: user.seller.id
        can :read, Seller, user_id: user.id 
        cannot :read, Customer
        cannot :read, Admin


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
