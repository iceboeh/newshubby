class CreateDistributions < ActiveRecord::Migration
  def change
    create_table :distributions do |t|
      t.text :geography
      t.text :niche
      t.text :comments

      t.timestamps
    end
  end
end
