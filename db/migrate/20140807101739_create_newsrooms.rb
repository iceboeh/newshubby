class CreateNewsrooms < ActiveRecord::Migration
  def change
    create_table :newsrooms do |t|
      t.string :company_name
      t.string :website
      t.string :press_phone
      t.string :press_email
      t.date :founded
      t.string :q_who_are_you
      t.string :q_what_you_do
      t.string :q_how_you_achieve
      t.string :q_clients

      t.timestamps
    end
  end
end
