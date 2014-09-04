class AddNewsroomFieldsToCompanyLaunch < ActiveRecord::Migration
  def change
    add_column :company_launches, :company_name, :string
    add_column :company_launches, :website, :string
    add_column :company_launches, :press_phone, :string
    add_column :company_launches, :press_email, :string
    add_column :company_launches, :founded, :date
  end
end
