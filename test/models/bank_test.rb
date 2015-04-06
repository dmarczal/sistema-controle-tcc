require 'test_helper'

class BankTest < ActiveSupport::TestCase
  test "new" do
    b = Bank.new
    b.date = Date.new 2015, 04, 20
    b.timeline = Timeline.first
    b.teachers.push Teacher.first
    assert b.save, 'Não salvou'
  end
end
