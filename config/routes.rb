Rails.application.routes.draw do
    # rotas gerais da aplicação
    get 'login' => 'application#login'
    get 'logout' => 'application#logout'

    # rotas do módulo do professor responsável
    scope 'responsavel', module: 'app', as: 'responsible_teacher' do
        get '/' => 'responsible_teacher#students'
        get 'alunos' => 'responsible_teacher#students'
        get 'professores' => 'responsible_teacher#teachers'
        get 'calendarios' => 'responsible_teacher#calendars'
        get 'timelines' => 'responsible_teacher#timelines'
        get 'bancas' => 'responsible_teacher#banks'
        get 'perfil' => 'responsible_teacher#profile'
    end

    # rotas do módulo do acadêmico
    scope 'academico', module: 'app', as: 'student' do
        get '/' => 'student#item'
        get 'item' => 'student#item'
        get 'perfil' => 'student#profile'
    end

    # rotas do módulo do professor orientador / membro de banca
    scope 'professor', module: 'app', as: 'teacher' do
        get '/' => 'teacher#entregas'
        get 'timelines' => 'teacher#timelines'
        get 'entregas' => 'teacher#entregas'
        get 'perfil' => 'teacher#profile'
    end

    # rotas da api
    namespace :api do
        # rotas da api para estudantes
        get 'student/all' => 'student#all'
        post 'student/new' => 'student#new'
        put 'student/edit/:id' => 'student#edit'
        delete 'student/delete/:id' => 'student#delete'
        put 'student/profile/:id' => 'student#editProfile'

        # rotas da api para professores
        get 'teacher/all' => 'teacher#all'
        post 'teacher/new' => 'teacher#new'
        put 'teacher/edit/:id' => 'teacher#edit'
        delete 'teacher/delete/:id' => 'teacher#delete'
        get 'teacher/pending/:id' => 'teacher#getPendingDocuments'
        get 'teacher/document/reprove/:id' => 'teacher#reproveDocument'
        get 'teacher/document/approve/:id' => 'teacher#approveDocument'
        put 'teacher/profile/:id' => 'teacher#editProfile'

        # rotas da api para base timeline
        get 'timeline/base/search/:year/:half/:tcc' => 'base_timeline#searchBase'
        get 'timeline/base/:id' => 'base_timeline#getBase'
        get 'timeline/base' => 'base_timeline#getBase'
        post 'timeline/base/item/new' => 'base_timeline#newItemBase'
        put 'timeline/base/item/edit' => 'base_timeline#editItemBase'
        delete 'timeline/base/item/delete/:id' => 'base_timeline#deleteItemBase'
        post 'timeline/base/json/:id' => 'base_timeline#setJson'

        #rotas da api para timeline
        post 'timeline/new' => 'timeline#new'
        get 'timeline/find/:year/:half/:tcc' => 'timeline#find'
        get 'timeline/find/teacher/:teacher/:year/:half/:tcc' => 'timeline#findByTeacher'
        get 'timeline/item/get/:id' => 'timeline#getItem'
        post 'timeline/item/send/:id' => 'timeline#sendFile'

        # rotas da api para bancas
        post 'banks/new' => 'banks#new'
        get 'banks/all' => 'banks#all'
        get 'banks/get/:id' => 'banks#get'
        get 'banks/find/:timeline' => 'banks#find_by_timeline'
        put 'banks/edit/:id' => 'banks#edit'
        delete 'banks/delete/:timeline' => 'banks#delete'

        # rotas da api para os métodos de controle do angularJS
        get 'messages' => 'page#messages'
        post 'login' => 'page#login'
    end
end
