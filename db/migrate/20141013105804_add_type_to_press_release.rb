class AddTypeToPressRelease < ActiveRecord::Migration
  def change
    add_column :press_releases, :pressrelease_type_id, :integer
    add_column :press_releases, :specifics, :text
  end
end
