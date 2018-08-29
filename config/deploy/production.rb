user = 'rails'
ip_address = '178.128.211.197'

role :app, ["#{user}@#{ip_address}"]
role :web, ["#{user}@#{ip_address}"]
role :db,  ["#{user}@#{ip_address}"]

server ip_address,
      user: user,
      roles: %w{web app}

set :rails_env, 'production'
set :bundle_flags, '--no-deployment'
set :nginx_server_name, '178.128.211.197'