class AddExclusiveToPressReleases < ActiveRecord::Migration
  def change
    add_column :press_releases, :exclusive, :boolean, default: true
  end
end
