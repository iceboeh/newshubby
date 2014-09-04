class AddTwitterToNewsroom < ActiveRecord::Migration
  def change
    add_column :newsrooms, :twitter, :string
  end
end
