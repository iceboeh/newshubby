class Newsroom < ActiveRecord::Base
  validates :term_agreement, presence: true
  
  extend FriendlyId
  friendly_id :company_name, use: :slugged
    
  geocoded_by :location
  after_validation :geocode, :if => :location_changed?


  def self.search(query)
    where("company_name LIKE ?", "%#{query}%")
  end

#  searchable do
#    text :company_name, :website, :q_who_are_you, :q_what_you_do, :q_how_you_achieve, :q_clients, :location
#   
#    text :company_launches do
#      company_launches.map(&:title)
#    end
#    
#    text :people do
#      people.map(&:name)
#    end
#    
#    text :fundings do
#      fundings.map(&:name)
#    end
#  end

  # Press release versions
  has_many :company_launches
  
  has_many :press_releases, dependent: :destroy
  
  # Static Newsroom stuff
  has_many :fundings, dependent: :destroy
  has_many :people, dependent: :destroy
  has_one :subscription, dependent: :destroy
  
  
  has_many :links, through: :press_releases
  has_many :uploads, through: :press_releases
  
  accepts_nested_attributes_for :company_launches, allow_destroy: true
  accepts_nested_attributes_for :people, allow_destroy: true
  accepts_nested_attributes_for :fundings, allow_destroy: true
  accepts_nested_attributes_for :company_launches, allow_destroy: true
  accepts_nested_attributes_for :press_releases, allow_destroy: true
  
  accepts_nested_attributes_for :links, allow_destroy: true
  accepts_nested_attributes_for :uploads, allow_destroy: true
  
  validates :term_agreement, acceptance: { accept: true }
  
  #validates_presence_of :logo, if: :on_logo_step?
  
  
  has_attached_file :logo, :styles => { :large => "800x800>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/,
  :less_than => 2.megabytes

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

end
