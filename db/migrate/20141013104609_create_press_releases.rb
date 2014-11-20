class CreatePressReleases < ActiveRecord::Migration
  def change
    create_table :press_releases do |t|
      t.text :title

      t.timestamps
    end
  end
end
