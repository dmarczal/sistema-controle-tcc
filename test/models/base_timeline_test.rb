require 'test_helper'

class BaseTimelineTest < ActiveSupport::TestCase
  fixtures :base_timelines
  test "validates_of" do
    base = BaseTimeline.new
    msg = 'base_timeline not save for empty'
    assert_not base.save, msg
    base.year = base_timelines(:one).year

    msg = 'base_timeline not save for empty half'
    assert_not base.save, msg
    base.half = base_timelines(:one).half

    msg = 'base_timeline not save for empty tcc'
    assert_not base.save, msg
    base.tcc = base_timelines(:one).tcc

    base.year = '20000'
    msg = 'base_timeline not save for invalid year'
    assert_not base.save, msg
  end
end
