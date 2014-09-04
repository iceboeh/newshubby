class AddFounderToPeople < ActiveRecord::Migration
  def change
    add_column :people, :founder, :boolean
  end
end
