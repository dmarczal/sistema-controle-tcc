require 'test_helper'

class BankNoteTest < ActiveSupport::TestCase
  test "validate unique note for one teacher and one bank" do
    bn = BankNote.new
    assert !bn.save, 'Salvou uma nota sem professor e sem banca'

    bn.bank = Bank.first
    assert !bn.save, 'Salvou uma nota sem professor'

    bn.teacher = Teacher.find(2)
    assert bn.save, 'Não salvou a nota '+bn.errors.inspect

    bn = BankNote.new
    bn.bank = Bank.first
    bn.teacher = Teacher.first

    assert !bn.save, 'Salvou uma BankNote repetida '+bn.errors.inspect
  end
end
