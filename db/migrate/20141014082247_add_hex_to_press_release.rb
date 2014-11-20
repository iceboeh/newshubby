class AddHexToPressRelease < ActiveRecord::Migration
  def change
    add_column :press_releases, :hex, :string
  end
end
