Rails.application.routes.draw do
    # rotas do site
    # scope 'site' do
        get '/' => 'site#home', as: :site_root
        get '/paginas/:slug' => 'site#page', as: :site_pages
        get '/fluxo-de-atividades' => 'site#activities', as: :site_activities
        get '/professores' => 'site#teachers', as: :site_teachers
        get '/aprovados' => 'site#approveds', as: :site_approveds
        get '/em-andamento' => 'site#in_progress', as: :site_in_progress
        get '/timeline/:tcc' => 'site#timeline', as: :site_timeline
        
        # to do
        get '/paginas' => 'site#pages', as: :site_list_pages
        get '/noticias' => 'site#notices', as: :site_notices
    # end

    # rotas gerais da aplicação
    get 'login' => 'application#login', as: :login
    post 'login' => 'application#login_post', as: :login_post
    get 'logout' => 'application#logout'
    # root 'application#login'

    # download de arquivos do dropbox
    get "files/get/:id" => "files#get", :as => "download"

    # rotas do módulo do professor responsável
    scope 'responsavel', module: 'app', as: 'responsible_teacher' do
        # dashboard
        get '/' => 'responsibleteachers/timelines#home', module: 'app'

        resources :students, module: 'responsibleteachers', path: 'academicos'
        resources :teachers, module: 'responsibleteachers', path: 'professores'

        resources :calendars, module: 'responsibleteachers', path: 'calendarios', format: :js
        get 'calendarios/:year/:half/:tcc' => 'responsibleteachers/calendars#show', module: 'app'
        get 'calendarios/:year/:half/:tcc/timeline' => 'responsibleteachers/calendars#timeline', module: 'app'
        post 'calendarios/:id/timeline/save' => 'responsibleteachers/calendars#save_timeline', module: 'app'

        resources :timelines, module: 'responsibleteachers', only: [:index, :show, :new, :create, :destroy, :edit, :update]
        get 'timelines/:year/:half/:tcc' => 'responsibleteachers/timelines#list', module: 'responsibleteachers'

        resources :banks, module: 'responsibleteachers', only: [:index, :show, :new, :create, :destroy, :edit, :update], path: 'bancas'
        resources :approvals, module: 'responsibleteachers', only: [:index, :show, :create, :destroy, :edit, :update], path: 'aprovados'
        get 'aprovados/new/:id' => 'responsibleteachers/approvals#new', as: :new_approval

        get 'orientacoes' => 'responsibleteachers/orientations#orientations'
        get 'orientacoes/:timeline' => 'responsibleteachers/orientations#orientations_by_timeline'
        get 'orientacao/:id' => 'responsibleteachers/orientations#orientation'

        resources :paginas, module: 'responsibleteachers', controller: :pages, as: :pages
        resources :noticias, module: 'responsibleteachers', controller: :notices, as: :notices
    end

    # rotas do módulo do acadêmico
    scope 'academico', module: 'app', as: 'student' do
        get '/' => 'students#timelines'
        get 'timeline/show/:id' => 'students#show_timeline', as: :show_timeline
        get 'timeline/:timeline_id/:id' => 'students#item', as: :delivery_item_get
        post 'timeline/:id' => 'students#delivery', as: :delivery_item

        get '/orientacoes' => 'students#orientations'
        get '/orientacoes/:id' => 'students#show_orientation', as: :show_orientation
        get '/orientacoes/:id/accept' => 'students#accept_orientation', as: :accept_orientation
    end

    # rotas do módulo do professor orientador / membro de banca
    scope 'professor', module: 'app', as: 'teachers' do
        get '/' => 'teachers/timelines#index'
        get 'timeline/:timeline_id/item/:id' => 'teachers/items#show', as: :item
        get 'timeline/:timeline_id/item/:id/aprovar' => 'teachers/items#approve', as: :approve
        get 'timeline/:timeline_id/item/:id/reprovar' => 'teachers/items#repprove', as: :repprove
        post 'timeline/:timeline_id/item/:id/reprovar' => 'teachers/items#repprove_post', as: :repprove_post

        get 'timelines' => 'teachers/timelines#index'
        get 'timelines/:id' => 'teachers/timelines#show', as: :timeline
        get 'timelines/:year/:half/:tcc' => 'teachers/timelines#list'

        get 'entregas' => 'teachers/items#pending', as: :pending

        get 'bancas' => 'teachers/banks#index'
        resources :orientacoes, :controller => 'orientations'
        post 'orientacoes/:id/edit' => 'orientations#editPost'
        get 'orientacoes/:id' => 'orientations#show'
    end

    # rotas do módulo do professor de TCC 1
    scope 'tcc1', module: 'app', as: 'tcc1' do
        get '/' => 'tcc1/timelines#index'
        get 'timeline/:timeline_id/item/:id' => 'tcc1/items#show', as: :item
        get 'timeline/:timeline_id/item/:id/aprovar' => 'tcc1/items#approve', as: :approve
        get 'timeline/:timeline_id/item/:id/reprovar' => 'tcc1/items#repprove', as: :repprove
        post 'timeline/:timeline_id/item/:id/reprovar' => 'tcc1/items#repprove_post', as: :repprove_post

        get 'timelines' => 'tcc1/timelines#index'
        get 'timelines/:id' => 'tcc1/timelines#show', as: :timeline
        get 'timelines/:year/:half' => 'tcc1/timelines#list'

        get 'entregas' => 'tcc1/items#pending', as: :pending
    end

    get  'password' => 'passwords#edit'
    post 'password' => 'passwords#update', as: :edit_password
end
