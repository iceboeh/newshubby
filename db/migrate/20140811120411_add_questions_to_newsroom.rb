class AddQuestionsToNewsroom < ActiveRecord::Migration
  def change
    add_column :newsrooms, :location, :string
    add_column :newsrooms, :business_model, :string
    add_column :newsrooms, :competitors, :string
    add_column :newsrooms, :differentiation, :string
    add_column :newsrooms, :problem_solved, :string
  end
end
