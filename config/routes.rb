Rails.application.routes.draw do
    # rotas gerais da aplicação
    get 'login' => 'application#login'

    # rotas do módulo do professor responsável
    scope 'responsavel', module: 'app', as: 'responsible_teacher' do
        get '/' => 'responsible_teacher#students'
        get 'alunos' => 'responsible_teacher#students'
        get 'professores' => 'responsible_teacher#teachers'
        get 'calendarios' => 'responsible_teacher#calendars'
        get 'timelines' => 'responsible_teacher#timelines'
    end

    # rotas da api
    namespace :api do
        # rotas da api para estudantes
        get 'student/all' => 'student#all'
        post 'student/new' => 'student#new'
        put 'student/edit/:id' => 'student#edit'
        delete 'student/delete/:id' => 'student#delete'

        # rotas da api para professores
        get 'teacher/all' => 'teacher#all'
        post 'teacher/new' => 'teacher#new'
        put 'teacher/edit/:id' => 'teacher#edit'
        delete 'teacher/delete/:id' => 'teacher#delete'

        # rotas da api para base timeline
        get 'timeline/base/search/:year/:half/:tcc' => 'base_timeline#searchBase'
        get 'timeline/base/:id' => 'base_timeline#getBase'
        get 'timeline/base' => 'base_timeline#getBase'
        post 'timeline/base/new' => 'base_timeline#newBase'
        put 'timeline/base/edit' => 'base_timeline#editBase'
        delete 'timeline/base/delete/:id' => 'base_timeline#deleteBase'
        post 'timeline/base/json/:id' => 'base_timeline#setJson'

        #rotas da api para timeline
        post 'timeline/new' => 'timeline#new'
        get 'timeline/find/:year/:half/:tcc' => 'timeline#find'

        # rotas da api para os métodos de controle do angularJS
        get 'messages' => 'page#messages'
        post 'login' => 'page#login'
    end
end
