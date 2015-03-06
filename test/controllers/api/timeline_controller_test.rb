require 'test_helper'

class Api::TimelineControllerTest < ActionController::TestCase
  test "save" do
    post = {
        student: 298486374,
        teacher: 980190962,
        year: 2015,
        half: 2,
        tcc: 2
    }

    post 'new', {:controller => 'api/timeline', :timeline => post}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['success'], 'Não teve sucesso ao salvar: '+resp.inspect
  end

  test "find" do
    get 'find', {:controller => 'api/timeline', :year => 2015, :half => 1, :tcc => 1}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['students'], 'Não teve sucesso ao buscar: '+resp.inspect
  end
end
