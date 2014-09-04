class AddAttachmentLogoToNewsrooms < ActiveRecord::Migration
  def self.up
    change_table :newsrooms do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :newsrooms, :logo
  end
end
