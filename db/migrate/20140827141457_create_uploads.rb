class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :company_launch_id
      t.string :caption

      t.timestamps
    end
  end
end
