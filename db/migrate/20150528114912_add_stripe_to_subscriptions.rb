class AddStripeToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :stripe_customer_token, :string
    add_column :subscriptions, :stripe_subscription_id, :string
  end
end
