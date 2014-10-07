class ChangeStringsToText < ActiveRecord::Migration
  def change
    change_column :people, :presentation, :text, :limit => nil
    change_column :newsrooms, :q_how_you_achieve, :text, :limit => nil
    change_column :newsrooms, :q_clients, :text, :limit => nil
    change_column :newsrooms, :differentiation, :text, :limit => nil
    change_column :newsrooms, :problem_solved, :text, :limit => nil
    change_column :newsrooms, :business_model, :text, :limit => nil
    change_column :newsrooms, :competitors, :text, :limit => nil
    change_column :company_launches, :q_how_you_achieve, :text, :limit => nil
    change_column :company_launches, :q_clients, :text, :limit => nil
    change_column :company_launches, :differentiation, :text, :limit => nil
    change_column :company_launches, :problem_solved, :text, :limit => nil
    change_column :company_launches, :business_model, :text, :limit => nil
    change_column :company_launches, :competitors, :text, :limit => nil
    change_column :company_launches, :quote, :text, :limit => nil
  end
end
