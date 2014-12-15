class Link < ActiveRecord::Base
  belongs_to :company_launch
  belongs_to :press_release
  belongs_to :newsroom
  
  #validates_uniqueness_of :caption, :scope => "press_release_id"
  #validates :caption, uniqueness: { scope: :press_release_id }
  
  validate :caption, :link_uniqueness
  
  def link_uniqueness
    if 1 != 2
    end
  end

end