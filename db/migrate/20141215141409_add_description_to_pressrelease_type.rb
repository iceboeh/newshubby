class AddDescriptionToPressreleaseType < ActiveRecord::Migration
  def change
    add_column :pressrelease_types, :description, :text
  end
end
