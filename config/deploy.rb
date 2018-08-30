lock '3.11.0'

# Change these
set :repo_url,        'git@github.com:dangminhtruong/devcamp.git'
set :application,     'devcamp'
set :user,            'rails'

set :pty,             true
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/#{fetch(:application)}/current"
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5

namespace :deploy do
  desc "seed database"
  task :seed do
    on roles(:db) do |host|
      within "#{release_path}" do
        execute :rake, "db:seed"
      end
    end
  end
end

set :puma_rackup, -> {File.join(current_path, "config.ru")}
set :puma_state, -> {"#{shared_path}/tmp/pids/puma.state"}
set :puma_pid, -> {"#{shared_path}/tmp/pids/puma.pid"}
set :puma_bind, -> {"unix://#{shared_path}/tmp/sockets/puma.sock"}
set :puma_conf, -> {"#{shared_path}/puma.rb"}
set :puma_access_log, -> {"#{shared_path}/log/puma_access.log"}
set :puma_error_log, -> {"#{shared_path}/log/puma_error.log"}
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, "staging"))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false