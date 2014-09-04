class AddCompanyLaunchIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :company_launch_id, :integer
  end
end
