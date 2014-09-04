class AddEmbargoToCompanyLaunch < ActiveRecord::Migration
  def change
    add_column :company_launches, :embargo, :date
  end
end
