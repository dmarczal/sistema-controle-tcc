require 'test_helper'

class Api::BaseTimelineControllerTest < ActionController::TestCase
  test "save_item" do
    base = {year: 2015, half: 1, tcc: 1}
    item = {
        title: 'Entrega de documento',
        _type: 'document',
        date: '20-02-2015',
        link: 'http://www.google.com.br',
        description: 'O acadêmico deve entregar um documento'
    }

    post 'newItemBase', {:controller => 'api/base_timeline', :item => item, :base => base}
    assert_response :success
    resp = JSON.parse response.body
    assert resp['success'], 'Erro ao cadastrar: '+resp.inspect
  end

  test "edit_item" do
    item = ItemBaseTimeline.first
    id = item.id
    item = {
        id: id,
        title: 'Entrega de documento1',
        _type: 'presentation',
        date: '20-02-2015',
        link: 'http://www.google.com.br',
        description: 'O acadêmico deve entregar um documento'
    }

    put 'editItemBase', {:controller => 'api/base_timeline', :item => item}
    assert_response :success
    resp = JSON.parse response.body
    assert resp['success'], 'Erro ao editar: '+resp.inspect

    item = ItemBaseTimeline.first
    assert item.title == 'Entrega de documento1'
  end

    test "delete_item" do
        item = ItemBaseTimeline.first
        id = item.id
        put 'deleteItemBase', {:controller => 'api/base_timeline', :id => id}
        assert_response :success
        resp = JSON.parse response.body
        assert resp['success'], 'Erro ao excluir: '+resp.inspect

        # items = ItemBaseTimeline.where :id => id
        # assert items.length == 0, 'Não excluiu o registro realmente: '+items.inspect
    end
end
