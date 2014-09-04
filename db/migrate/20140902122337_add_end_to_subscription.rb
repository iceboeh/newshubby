class AddEndToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :end, :datetime
  end
end
