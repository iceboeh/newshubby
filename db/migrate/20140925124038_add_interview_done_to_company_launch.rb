class AddInterviewDoneToCompanyLaunch < ActiveRecord::Migration
  def change
    add_column :company_launches, :interview_done, :boolean
  end
end
