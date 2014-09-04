class AddLatLongToNewsroom < ActiveRecord::Migration
  def change
    add_column :newsrooms, :longitude, :float
    add_column :newsrooms, :latitude, :float
  end
end
