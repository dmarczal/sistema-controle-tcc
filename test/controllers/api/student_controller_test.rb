require 'test_helper'

class Api::StudentControllerTest < ActionController::TestCase
  test "edit" do
    student = {name: 'Érico'}
    put 'edit', {:controller => 'api/student', :id => 987, :student => student}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['errors'], 'Não apresentou erros para um estudante que não existe: '+resp.inspect
  end
end
