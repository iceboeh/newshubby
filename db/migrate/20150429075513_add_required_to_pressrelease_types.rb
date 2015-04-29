class AddRequiredToPressreleaseTypes < ActiveRecord::Migration
  def change
    add_column :pressrelease_types, :required_fields, :string
  end
end
