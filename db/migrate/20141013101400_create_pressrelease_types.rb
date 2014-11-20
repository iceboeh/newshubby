class CreatePressreleaseTypes < ActiveRecord::Migration
  def change
    create_table :pressrelease_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
