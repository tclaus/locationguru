class SubscriptionsController < ApplicationController
  def view
    @hasSubscription = hasSubscription
    render 'subscriptions/type_of_subscription'
  end

  def toggleSubscription
    if hasSubscription
      revokeSubscription
      flash[:notice] = t('.you_have_revoked_your_subscription')
    else
      if
        if current_user.stripe_id.blank?
          flash[:notice] = t('.you_must_enter_a_card_first')
        end
      end
      activateSubscription
      flash[:notice] = t('.you_have_started_your_subscription')
    end
    redirect_to subscriptions_path
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
          plan: ENV['stripe_subscription_id']
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
