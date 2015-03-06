require 'test_helper'

class ItemBaseTimelineTest < ActiveSupport::TestCase
  fixtures :item_base_timelines
  test "validates_of" do
    item = ItemBaseTimeline.new
    msg = 'item_base_timeline not save for empty'
    assert_not item.save, msg

    item.description = item_base_timelines(:one).description
    msg = 'not save item_base_timeline for empty title'
    assert_not item.save, msg

    item.title = item_base_timelines(:one).title
    # item.date = item_base_timelines(:one).date
    item._type = item_base_timelines(:one)._type
    item.link = item_base_timelines(:one).link

    msg = 'save item_base_timeline with success '+item.errors.inspect
    assert_not item.save, msg
  end
end
