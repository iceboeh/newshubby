class AddTermsToNewsroom < ActiveRecord::Migration
  def change
    add_column :newsrooms, :term_agreement, :boolean
  end
end
