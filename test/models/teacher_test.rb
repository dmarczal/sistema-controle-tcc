require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  fixtures :teachers
  test 'validates_of' do
    t = Teacher.new
    assert_not t.save, 'Not save empty teacher'

    t.name = teachers(:one).name
    t.email = teachers(:one).email

    t.lattes = teachers(:one).lattes
    t.atuacao = teachers(:one).atuacao

    assert_not t.save, 'Save teacher with empty login'
    t.login = 'diego'

    assert_not t.save, 'Save teacher with not role'
    t.role = Role.first

    assert t.save, 'Not save teacher with complete data'
  end
end
