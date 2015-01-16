class Upload < ActiveRecord::Base
  belongs_to :company_launch
  belongs_to :press_release
  
  has_attached_file :file, :styles => { :large => "800x600>",:medium => "640x480>", :small => "320x240>" }, :default_url => "images/feature_img.png"
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
  
end
