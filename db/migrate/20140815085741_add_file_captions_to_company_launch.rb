class AddFileCaptionsToCompanyLaunch < ActiveRecord::Migration
  def change
    add_column :company_launches, :caption_file1, :string
    add_column :company_launches, :caption_file2, :string
    add_column :company_launches, :caption_file3, :string
  end
end
