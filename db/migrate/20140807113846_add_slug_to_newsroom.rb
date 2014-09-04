class AddSlugToNewsroom < ActiveRecord::Migration
  def change
    add_column :newsrooms, :slug, :string
    add_index :newsrooms, :slug, unique: true
  end
end
