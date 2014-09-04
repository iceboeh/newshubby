class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :link
      t.integer :company_launches_id
      t.string :caption

      t.timestamps
    end
  end
end
