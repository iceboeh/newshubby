class AddTextToCompanyLaunches < ActiveRecord::Migration
  def change
    add_column :company_launches, :text, :text
  end
end
