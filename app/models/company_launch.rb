class CompanyLaunch < ActiveRecord::Base
  belongs_to :newsroom
  has_many :links, dependent: :destroy
  has_many :uploads, dependent: :destroy
  
  accepts_nested_attributes_for :links, allow_destroy: true
  accepts_nested_attributes_for :uploads, allow_destroy: true
  
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  has_attached_file :file1, :styles => { :medium => ["300x300>", :png], :thumb => ["100x100#", :png] }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :file1, :content_type => [/\Aimage\/.*\Z/, "application/pdf"],
  :less_than => 2.megabytes
  
  has_attached_file :file2, :styles => { :medium => ["300x300>", :png], :thumb => ["100x100#", :png] }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :file2, :content_type => [/\Aimage\/.*\Z/, "application/pdf"],
  :less_than => 2.megabytes
  
  has_attached_file :file3, :styles => { :medium => :medium => ["300x300>", :png], :thumb => ["100x100#", :png] }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :file3, :content_type => [/\Aimage\/.*\Z/, "application/pdf"],
  :less_than => 2.megabytes
  
end
