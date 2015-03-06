require 'test_helper'

class Api::BaseTimelineControllerTest < ActionController::TestCase
  test "save_base_timeline" do
    base = {
        'year' => 2015,
        'half' => 2,
        'tcc' => 2,
        'json' => 'Um json',
    }

    items = [{
                 'description' => 'O acadêmico deve procurar os professores de TSI para conhecer suas linhas de pesquisas, projeto que estão trabalhando, áreas de interesse, etc. Com o intuito de encontrar um orientador e tema para o TCC',
                 'title' => 'Buscar por um orientador e tema',
                 '_type' => 'warning',
                 'link' => 'http://tcc.tsi.gp.utfpr.edu.br/',
                 'date' => '07-05-2015'
             },
             {
                 'description' => 'O acadêmico deve procurar os professores de TSI para conhecer suas linhas de pesquisas, projeto que estão trabalhando, áreas de interesse, etc. Com o intuito de encontrar um orientador e tema para o TCC',
                 'title' => 'Buscar por um orientador e tema',
                 '_type' => 'document',
                 'link' => 'http://tcc.tsi.gp.utfpr.edu.br/',
                 'date' => '07-05-2015'
             }
    ]
    base[:items] = items
    post 'newBase', {:controller => 'api/base_timeline', :base => base}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['success'], 'Não teve sucesso ao salvar: '+resp.inspect
  end

  test "get_base_timeline" do
    get 'getBase', {:controller => 'api/base_timeline', :id => 298486374}
    assert_response :success
    base = JSON.parse response.body
    assert_not_nil base['data']['id'], 'Não teve sucesso ao buscar o registro: '+base.inspect

    get 'getBase', {:controller => 'api/base_timeline', :id => 'kkkkkkk'}
    assert_response :success
    resp = JSON.parse response.body
    assert_not_nil resp['errors'].length, 'não acusou erro com um id inválido'
  end
  #
  test "edit_base_timeline" do
    get 'getBase', {:controller => 'api/base_timeline', :id => 298486374}
    assert_response :success
    base = JSON.parse response.body
    assert_not_nil base['data']['id'], 'não conseguiu achar o registro'
    half = base['data']['half']

    base = {
        'id' => 298486374,
        'year' => 2015,
        'half' => 1,
        'tcc' => 1,
        'json' => 'Um json',
    }

    items = [{
                 'id' => 298486374,
                 'description' => 'O acadêmico deve procurar os professores de TSI para conhecer suas linhas de pesquisas, projeto que estão trabalhando, áreas de interesse, etc. Com o intuito de encontrar um orientador e tema para o TCC',
                 'title' => 'Buscar por um orientador e tema',
                 '_type' => 'warning',
                 'link' => 'http://tcc.tsi.gp.utfpr.edu.br/',
                 'date' => '2015-07-05'
             },
             {
                 'id' => 980190962,
                 'description' => 'O acadêmico deve procurar os professores de TSI para conhecer suas linhas de pesquisas, projeto que estão trabalhando, áreas de interesse, etc. Com o intuito de encontrar um orientador e tema para o TCC',
                 'title' => 'Buscar por um orientador e tema',
                 '_type' => 'document',
                 'link' => 'http://tcc.tsi.gp.utfpr.edu.br/',
                 'date' => '2015-07-05'
             }
    ]

    base[:items] = items
    put 'editBase', {:controller => 'api/base_timeline', :base => base}
    assert_response :success
    base = JSON.parse response.body
    assert_not_nil base['success'], 'não teve sucesso ao editar o item'

    get 'getBase', {:controller => 'api/base_timeline', :id => 298486374}
    assert_response :success
    base = JSON.parse response.body
    assert_not_nil base['data']['half'] == half, 'o registro editado não bate com o buscado'
  end

  test "delete base base_timeline" do
    get 'getBase', {:controller => 'api/base_timeline', :id => 298486374}
    assert_response :success
    base = JSON.parse response.body
    assert_not_nil base['data']['id'], 'não conseguiu achar o registro a excluir'

    delete 'deleteBase', {:controller => 'api/base_timeline', :id => 298486374}
    assert_response :success
    base = JSON.parse response.body
    assert_not_nil base['success'].length, 'não teve sucesso ao excluir o item'

    delete 'deleteBase', {:controller => 'api/base_timeline', :id => 298486374}
    assert_response :success
    base = JSON.parse response.body
    assert_not_nil base['errors'].length, 'o registro pode ser excluido 2 vezes '
  end
end
