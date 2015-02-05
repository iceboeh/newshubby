class Subscription < ActiveRecord::Base
  belongs_to :plan
  belongs_to :newsroom
  validates_presence_of :plan_id
  validates_presence_of :email
  
  attr_accessor :stripe_card_token, :email
  
  #before_destroy :cancel_subscription
  
  def save_with_payment
  
    unless self.newsroom.nil?
    stripe_customer = self.newsroom.subscriptions.first.stripe_customer_token
    end
    
    if valid?
      if stripe_customer.blank?
        customer = Stripe::Customer.create(card: stripe_card_token, plan: plan_id)
        self.stripe_customer_token = customer.id
      else
        customer = Stripe::Customer.retrieve(stripe_customer)
        subscription = customer.subscriptions.create(plan: plan_id)
        self.stripe_subscription_id = subscription.id
        self.stripe_customer_token = customer.id
      end
      save!
    end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
    end
  
  #customer.subscriptions.data[0]

  # Gör det rakt bara. Följ API-guiden och skriv själv.
  # Customer.retrieve -> Subscription.retrieve.delete

  def cancel_subscription
    customer_id = stripe_customer_token
    subscription_id = stripe_subscription_id
    
    unless customer_id.nil?
      unless subscription_id.nil?
        customer = Stripe::Customer.retrieve(customer_id).subscriptions.retrieve(stripe_subscription_id).delete
      else
        customer = Stripe::Customer.retrieve(customer_id).subscriptions.data[0].delete
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
  end
  
  
end
