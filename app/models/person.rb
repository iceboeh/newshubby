class Person < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :newsroom
  
  #validates :name, scope: :newsroom_id, uniqueness: true
end
