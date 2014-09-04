class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.string :role
      t.string :presentation
      t.string :newsroom_id

      t.timestamps
    end
  end
end
