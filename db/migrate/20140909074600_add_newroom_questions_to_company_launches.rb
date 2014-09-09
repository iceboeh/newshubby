class AddNewroomQuestionsToCompanyLaunches < ActiveRecord::Migration
  def change
    add_column :company_launches, :q_what_you_do, :string
    add_column :company_launches, :q_how_you_achieve, :string
    add_column :company_launches, :q_clients, :string
    add_column :company_launches, :differentiation, :string
    add_column :company_launches, :problem_solved, :string
    add_column :company_launches, :business_model, :string
    add_column :company_launches, :competitors, :string
  end
end
