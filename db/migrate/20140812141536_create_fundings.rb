class CreateFundings < ActiveRecord::Migration
  def change
    create_table :fundings do |t|
      t.string :investment_type
      t.string :name
      t.date :date
      t.integer :amount
      t.string :newsroom_id

      t.timestamps
    end
  end
end
