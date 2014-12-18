class Link < ActiveRecord::Base
  belongs_to :company_launch
  belongs_to :press_release
end