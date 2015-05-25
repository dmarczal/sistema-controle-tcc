class ItemBaseTimeline < ActiveRecord::Base
  belongs_to :base_timeline
  has_many :item_timeline

  validates_presence_of :description
  validates_presence_of :title
  validates_presence_of :_type
  validates_presence_of :date
  validates_presence_of :base_timeline_id
end
