class AddLaunchToCompanyLaunches < ActiveRecord::Migration
  def change
    add_column :company_launches, :launch, :date
  end
end
