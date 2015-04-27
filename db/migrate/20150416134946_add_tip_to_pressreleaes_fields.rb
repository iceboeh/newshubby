class AddTipToPressreleaesFields < ActiveRecord::Migration
  def change
    add_column :pressreleaes_fields, :tip, :text
  end
end
