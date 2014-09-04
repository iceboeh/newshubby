class AddSlugToCompanyLaunches < ActiveRecord::Migration
  def change
    add_column :company_launches, :slug, :string
  end
end
