class ChangeStringToTextCompanyLaunches < ActiveRecord::Migration
  def change
    change_column :company_launches, :q_what_you_do, :text, :limit => nil
  end
end
