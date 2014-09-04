class AddHexToCompanyLaunches < ActiveRecord::Migration
  def change
    add_column :company_launches, :hex, :string
  end
end
