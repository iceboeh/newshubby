class AddIdToPressreleaesField < ActiveRecord::Migration
  def change
    add_column :pressreleaes_fields, :pressrelease_type_id, :integer
  end
end
