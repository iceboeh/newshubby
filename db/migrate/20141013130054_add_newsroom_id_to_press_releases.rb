class AddNewsroomIdToPressReleases < ActiveRecord::Migration
  def change
    add_column :press_releases, :newsroom_id, :integer
  end
end
