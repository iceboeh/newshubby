class PressRelease < ActiveRecord::Base
  belongs_to :pressrelease_type
  belongs_to :newsroom
  has_many :uploads, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :people, through: :newsroom, dependent: :destroy
  has_many :fundings, through: :newsroom, dependent: :destroy
  serialize :specifics, Hash
  
  accepts_nested_attributes_for :newsroom, allow_destroy: true
  accepts_nested_attributes_for :links, allow_destroy: true
  accepts_nested_attributes_for :uploads, allow_destroy: true
  accepts_nested_attributes_for :people, allow_destroy: true
  accepts_nested_attributes_for :fundings, allow_destroy: true
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
    
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
