class Link < ActiveRecord::Base
  belongs_to :company_launch
  belongs_to :press_release
  
  #validates_uniqueness_of :caption, allow_blank: false, scope: :press_release_id
end