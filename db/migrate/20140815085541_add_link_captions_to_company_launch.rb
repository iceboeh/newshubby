class AddLinkCaptionsToCompanyLaunch < ActiveRecord::Migration
  def change
    add_column :company_launches, :caption_link1, :string
    add_column :company_launches, :caption_link2, :string
  end
end
