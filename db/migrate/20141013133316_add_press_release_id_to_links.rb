class AddPressReleaseIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :press_release_id, :integer
  end
end
