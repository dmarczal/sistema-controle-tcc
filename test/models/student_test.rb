require 'test_helper'
require 'securerandom'

class StudentTest < ActiveSupport::TestCase
  fixtures :students

  test 'validates_of' do
    student = Student.new(:ra => students(:one).ra, :name => students(:one).name)
    msg = 'student not save for equal ra'
    assert_not student.save, msg

    student.ra = 111111
    student.email = 'erico_testes@yahoo.com.br'
    msg = 'student save for uniqueness ra'
    assert student.save, msg+student.errors.inspect

    student.name = nil
    msg = 'student not save with empty name'
    assert_not student.save, msg
  end
end
