require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  fixtures :teachers
  test 'validates_of' do
    t = Teacher.new
    assert_not t.save, 'Not save empty teacher'

    t.name = teachers(:one).name
    assert_not t.save, 'Not save teacher if name is type of access is empty'

    t.access = teachers(:one).access
    assert t.save, 'Save teacher for name and access not empty'

    t.lattes = teachers(:one).lattes
    t.atuacao = teachers(:one).atuacao

    assert t.save, 'Save teacher with complete data'
  end
end
