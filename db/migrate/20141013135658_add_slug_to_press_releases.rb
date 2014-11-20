class AddSlugToPressReleases < ActiveRecord::Migration
  def change
    add_column :press_releases, :slug, :string
    add_index :press_releases, :slug
  end
end
