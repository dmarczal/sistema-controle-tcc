require 'test_helper'

class ApprovalTest < ActiveSupport::TestCase

  def setup
  end


  test "create a valid Aproval" do
    assert_difference 'Approval.count' do
      create(:approval)
    end
  end

  test "should return approval banks group by year" do
    @tcc2 = []
    @tcc2 << create(:bank_tcc2, date: Time.now)
    @tcc2 << create(:bank_tcc2, date: Time.now)
    @tcc2 << create(:bank_tcc2, date: 1.year.ago)
    @tcc2 << create(:bank_tcc2, date: 2.year.ago)
    @tcc2 << create(:bank_tcc2, date: 2.year.ago)

    @tcc2.each do |t|
      create(:approval, bank: t)
    end

    tccs = Approval.tccs
    key_1 = Time.now.strftime('%Y')
    key_2 = 1.year.ago.strftime('%Y')
    key_3 = 2.year.ago.strftime('%Y')

    assert_equal 5, Approval.count
    assert_equal 3, tccs.size
    
    assert tccs[key_1].include?(@tcc2[0].approval)
    assert tccs[key_1].include?(@tcc2[1].approval)
    
    assert tccs[key_2].include?(@tcc2[2].approval)

    assert tccs[key_3].include?(@tcc2[3].approval)
    assert tccs[key_3].include?(@tcc2[4].approval)
  end

end
