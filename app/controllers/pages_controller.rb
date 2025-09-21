class PagesController < ApplicationController
  def home

    @posts = Post.all

  end

  def create_checkout_session
    plan = params[:plan] || "monthly"

    price_id =
      if plan == "yearly"
        Rails.application.credentials.dig(:stripe, :yearly_price_id)
      else
        Rails.application.credentials.dig(:stripe, :monthly_price_id)
      end

    session = Stripe::Checkout::Session.create({
      customer_email: current_user.email,
      payment_method_types: ['card'],
      line_items: [{
        price: price_id,
        quantity: 1
      }],
      mode: 'subscription',
      success_url: subscription_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: pricing_url,
    })

    redirect_to session.url, allow_other_host: true
  end

  def subscription_success
    session_id = params[:session_id]
    session = Stripe::Checkout::Session.retrieve(session_id)

    current_user.update(
      stripe_customer_id: session.customer,
      stripe_subscription_id: session.subscription,
      subscribed: true
    )

    redirect_to root_path, notice: "Subscription successful! You now have access to pro episodes."
  end

  def pricing
  end

  def privacy
  end

  def profile

  end
end
