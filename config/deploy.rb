# config valid only for current version of Capistrano
lock '3.4.0'

set :user,            'apps'
set :application, "tcc.tsi.gp.educacional.mat.br"

set :scm, :git
set :branch, "deploy"
set :repo_url, 'git@github.com:dmarczal/sistema-controle-tcc.git'
set :keep_releases, 3

set :format, :pretty
set :log_level, :debug
set :pty, true

set :rails_env,       "production"
set :deploy_via,      :remote_cache
set :use_sudo,        false
set :deploy_to, "/home/#{fetch(:user)}/apps/rails/#{fetch(:application)}"

set :linked_files, %w{config/database.yml config/dropbox.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/attachments}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
