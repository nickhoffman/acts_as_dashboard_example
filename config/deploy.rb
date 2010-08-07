set :stages,  %w(production)
require       'capistrano/ext/multistage'

set :application, 'acts_as_dashboard_example'

set :domain,      'cretaceouslabs.com'
set :user,        'nick'
set :port,        9323
set :scm,         :git
set :scm_verbose, true
set :repository,  'http://github.com/nickhoffman/acts_as_dashboard_example.git'
set :branch,      'master'
set :deploy_via,  :export

set :use_sudo, false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

default_run_options[:pty] = true 

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do
      puts "*** The '#{t}' task is a no-op with Passenger/mod_rails."
    end
  end
end

