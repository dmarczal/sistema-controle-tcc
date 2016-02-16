require 'test_helper'

class BankTest < ActiveSupport::TestCase
  
  test "create a valid bank" do
    assert_difference 'Bank.count' do
      bank = create(:bank_proposta)
    end
  end

end
