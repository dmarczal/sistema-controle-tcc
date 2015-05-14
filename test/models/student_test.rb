require 'test_helper'
require 'securerandom'

class StudentTest < ActiveSupport::TestCase
  fixtures :students

  test 'validates_of' do
    student = Student.new(:ra => students(:one).ra, :name => students(:one).name, :login => students(:one).login, :email => students(:one).email)
    msg = 'student not save for equal ra'
    assert_not student.save, msg

    student.ra = 111111
    student.name = nil
    msg = 'student not save with empty name'
    assert_not student.save, msg

    student.name = students(:one).name
    student.email = 'hfasgyaeui@kadswo'
    msg = 'student not save with invalid email'
    assert_not student.save, msg

    student.email = 'aluno@yahoo.com.br'
    student.login = nil
    msg = 'student not save with empty login'
    assert_not student.save, msg

    student.login = 'algumlogin'
    msg = 'student save with complete data'
    assert student.save, msg+student.errors.inspect

    student.ra = students(:two).ra
    student.email = students(:one).email
    msg = 'student not save with duplicated email'
    assert_not student.save, msg

    student.email = students(:two).email
    student.login = students(:one).login
    msg = 'student not save with duplicated login'
    assert_not student.save, msg

    student.login = 'outrologin'
    student.email = 'email@email.com'
    student.ra = 20
    msg = 'student not save with complete data'
    assert student.save, msg+student.errors.inspect
  end
end
