class SubscriptionsController < ApplicationController
  def view
    @hasSubscription = hasSubscription
    render 'type_of_subscription'
  end

  def toggleSubscription
    if hasSubscription
      revokeSubscription
    else
      if flash[:notice] = 'You have activated a subscription'
        if current_user.stripe_id.blank?
          flash[:notice] = 'enter a card first'
          render '/payment_method'
        else
          # has a card?
        end
      end
      activateSubscription
    end
    render 'type_of_subscription'
  end

  private

  def hasSubscription
    unless current_user.stripe_id.blank?
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      return true if customer[:subscriptions].total_count > 0
    end
    false
  end

  def activateSubscription
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    Stripe::Subscription.create(
      customer: customer.id.to_s,
      items: [
        {
          plan: ENV['subscription_id']
        }
      ]
    )
  end

  def revokeSubscription
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    first_subscription = customer[:subscriptions][:data][0]
    sub = Stripe::Subscription.retrieve(first_subscription.id)
    sub.delete
  end
end
