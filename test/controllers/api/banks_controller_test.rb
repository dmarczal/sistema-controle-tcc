require 'test_helper'

class Api::BanksControllerTest < ActionController::TestCase
  test "new" do
    bank = {
        date: "20-04-2015",
        timeline_id: 1
    }

    teachers = [1, 2, 3]

    post 'new', {:controller => 'api/banks', :bank => bank, :teachers => teachers}
    assert_response :success
    resp = JSON.parse response.body
    assert resp['success'], 'Erro ao cadastrar: '+resp.inspect
  end

  test "get" do
    get 'get', {:controller => 'api/banks', :id => 298486374}
    assert_response :success
    resp = JSON.parse response.body
    puts resp
    assert resp['data'], 'Erro ao buscar: '+resp.inspect

    get 'get', {:controller => 'api/banks', :id => 1}
    assert_response :success
    resp = JSON.parse response.body
    assert resp['errors'].length > 0, 'Não apresentou erros com id inválido: '+resp.inspect
  end

  test "edit" do
    data = {
        timeline_id: 1,
        date: "10-04-2015",
    }
    teachers = [1, 2, 3]

    put 'edit', {:controller => 'api/banks', :id => 298486374, :bank => data, :teachers => teachers}
    assert_response :success
    resp = JSON.parse response.body
    assert resp['success'], 'Erro ao editar: '+resp.inspect
  end
end