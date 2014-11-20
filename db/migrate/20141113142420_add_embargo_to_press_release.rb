class AddEmbargoToPressRelease < ActiveRecord::Migration
  def change
    add_column :press_releases, :embargo, :datetime
  end
end
