class StatusItem < ActiveRecord::Base
  has_many :item_timelines
  validates_presence_of :name
end
