require 'test_helper'

class Api::TeacherControllerTest < ActionController::TestCase
  test "new" do
    teacher = {access: 'responsible', lattes: 'http://www.google.com.br', atuacao: 'Programação web'}
    post 'new', {:controller => 'api/teacher', :teacher => teacher}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['errors'], 'Não apresentou erros para um professor sem nome: '+resp.inspect
  end
end
