class AddPressReleaseIdToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :press_release_id, :integer
  end
end
