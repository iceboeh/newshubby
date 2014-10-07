class ChangeStringToTextLimigt < ActiveRecord::Migration
  def change
    change_column :newsrooms, :q_what_you_do, :text, :limit => nil
  end
end
