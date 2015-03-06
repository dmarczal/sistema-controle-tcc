class ItemTimeline < ActiveRecord::Base
  belongs_to :item_base_timeline
  belongs_to :timeline
end
