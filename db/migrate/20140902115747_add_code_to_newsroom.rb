class AddCodeToNewsroom < ActiveRecord::Migration
  def change
    add_column :newsrooms, :code, :string
  end
end
