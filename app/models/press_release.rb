class PressRelease < ActiveRecord::Base
  belongs_to :pressrelease_type
  belongs_to :newsroom
  has_many :uploads
  has_many :links
  has_many :people, through: :newsroom
  has_many :fundings, through: :newsroom
  serialize :specifics, Hash
  
  accepts_nested_attributes_for :newsroom, allow_destroy: true
  accepts_nested_attributes_for :links, allow_destroy: true
  accepts_nested_attributes_for :uploads, allow_destroy: true
  accepts_nested_attributes_for :people, allow_destroy: true
  accepts_nested_attributes_for :fundings, allow_destroy: true
  
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validate :validate_specifics  
  
  def self.search(query)
    where("title LIKE ?", "%#{query}%") 
  end
  
  def validate_specifics
    pressrelease_type.fields.each do |field|
      if field.required? && specifics[field.name].blank?
        errors.add field.name, "cannot be blank"
      end
    end
  end
    
end
