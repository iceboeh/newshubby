class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :code
      t.integer :duration

      t.timestamps
    end
  end
end
