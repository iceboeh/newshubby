class AddRelationToDistribution < ActiveRecord::Migration
  def change
    add_column :distributions, :press_release_id, :integer
  end
end
