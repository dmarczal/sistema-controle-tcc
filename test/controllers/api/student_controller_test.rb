require 'test_helper'

class Api::StudentControllerTest < ActionController::TestCase
  test "edit" do
    student = {name: 'Érico'}
    put 'edit', {:controller => 'api/student', :id => 987, :student => student}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['errors'], 'Não apresentou erros para um estudante que não existe: '+resp.inspect
  end

  test "login" do
    student = {name: 'Érico', ra: 1462562, login: 'erico', password: '12345', email: 'erico_testes@yahoo.com.br'}
    post 'new', {:controller => 'api/student', :student => student}
    assert_response :success
    resp = JSON.parse response.body
    assert resp['success'], 'login failure '+resp.inspect

    student = Student.last
    l = student.login
    login = {login: l.login, password: l.password}
    resp = JSON.parse response.body
    assert_not_nil resp['success'], response.body.inspect
  end

end
