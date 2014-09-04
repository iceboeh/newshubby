class AddAttachmentFile1File2File3ToCompanyLaunches < ActiveRecord::Migration
  def self.up
    change_table :company_launches do |t|
      t.attachment :file1
      t.attachment :file2
      t.attachment :file3
    end
  end

  def self.down
    remove_attachment :company_launches, :file1
    remove_attachment :company_launches, :file2
    remove_attachment :company_launches, :file3
  end
end
