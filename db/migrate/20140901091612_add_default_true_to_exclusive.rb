class AddDefaultTrueToExclusive < ActiveRecord::Migration

  def up
    change_column :company_launches, :exclusive, :boolean, :default => true
  end

  def down
    change_column :company_launches, :exclusive, :boolean, :default => nil
  end

end
