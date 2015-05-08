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
    assert resp['errors'].length > 0, 'Erro ao buscar: '+resp.inspect

    get 'get', {:controller => 'api/banks', :id => 1}
    assert_response :success
    resp = JSON.parse response.body
    assert resp['errors'] == nil, 'Apresentou erros: '+resp.inspect
  end

  test "edit" do
    data = {
        timeline_id: 1,
        date: "10-04-2015",
    }
    teachers = [1, 2, 3]

    put 'edit', {:controller => 'api/banks', :id => 1, :bank => data, :teachers => teachers}
    assert_response :success
    resp = JSON.parse response.body
    assert resp['success'], 'Erro ao editar: '+resp.inspect
  end

  test 'get_by_teacher' do
    get 'findByTeacher', {:controller => 'api/banks', :teacher_id => 1}
    assert_response :success
    resp = JSON.parse response.body
    assert resp.length > 0, 'Não trouxe registros'
  end

  test 'setNote' do
    post 'setNote', {:controller => 'api/banks', :bank_id => 1, :teacher_id => 1, :note => 4.5}
    assert_response :success
    resp = JSON.parse response.body
    assert resp['success'].nil?, 'Não teve sucesso ao salvar'

    post 'setNote', {:controller => 'api/banks', :bank_id => 1, :teacher_id => 1, :note => 4.5}
    assert_response :success
    resp = JSON.parse response.body
    assert_nil resp['success'], 'Salvou 2 vezes com mesmo professor e mesma banca'
  end
end