class AddFieldsToCompanyLaunches < ActiveRecord::Migration
  def change
    add_column :company_launches, :quote, :string
    add_column :company_launches, :link1, :string
    add_column :company_launches, :link2, :string
    add_column :company_launches, :exclusive, :boolean, :default => true
  end
end
