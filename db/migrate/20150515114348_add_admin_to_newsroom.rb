class AddAdminToNewsroom < ActiveRecord::Migration
  def change
    add_column :newsrooms, :admin, :boolean
  end
end
