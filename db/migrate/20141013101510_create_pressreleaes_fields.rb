class CreatePressreleaesFields < ActiveRecord::Migration
  def change
    create_table :pressreleaes_fields do |t|
      t.string :name
      t.string :field_type
      t.boolean :required
      t.text :question
      t.text :example
      t.text :prefill

      t.timestamps
    end
  end
end
