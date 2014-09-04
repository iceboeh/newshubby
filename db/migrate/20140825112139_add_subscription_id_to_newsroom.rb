class AddSubscriptionIdToNewsroom < ActiveRecord::Migration
  def change
    add_column :newsrooms, :subscription_id, :integer
  end
end
