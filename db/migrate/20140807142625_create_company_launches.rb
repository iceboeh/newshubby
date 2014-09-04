class CreateCompanyLaunches < ActiveRecord::Migration
  def change
    create_table :company_launches do |t|
      t.integer :newsroom_id
      t.string :title

      t.timestamps
    end
  end
end
