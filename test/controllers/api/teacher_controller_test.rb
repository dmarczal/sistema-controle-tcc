require 'test_helper'

class Api::TeacherControllerTest < ActionController::TestCase
  test "new" do
    teacher = {access: 'responsible', lattes: 'http://www.google.com.br', atuacao: 'Programação web'}
    post 'new', {:controller => 'api/teacher', :teacher => teacher}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['errors'], 'Não apresentou erros para um professor sem nome: '+resp.inspect
  end

  test "get_pending_documents" do
    get 'getPendingDocuments', {:controller => 'api/teacher', :id => 1}
    assert_response :success
    resp = JSON.parse response.body
    assert resp.length > 0, 'Não trouxe nenhum documento.'
  end

  test "approve_document" do
    get 'approveDocument', {:controller => 'api/teacher', :id => 1}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['success'], 'Não teve sucesso.'+resp.inspect
  end

  test "reprove_document" do
    get 'reproveDocument', {:controller => 'api/teacher', :id => 1}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['success'], 'Não teve sucesso.'+resp.inspect
  end
end
