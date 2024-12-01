# config valid for current version and patch releases of Capistrano
lock "~> 3.19.2"

set :application, "magicbox-enhanced"
set :repo_url, "https://github.com/HydroToxin/magicbox-enhanced.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/apps/magicbox"

after 'deploy:updated', 'deploy:migrate'

set :default_env, {
  path: "/home/magicbox/.rvm/rubies/ruby-3.2.5/bin/ruby:$PATH",
   LD_LIBRARY_PATH: "/home/magicbox/.rvm/rubies/ruby-3.2.5/lib:$LD_LIBRARY_PATH"
}

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
set :linked_dirs, fetch(:linked_dirs, []).push('builds')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

set :ssh_options, {
  user: 'magicbox',
  keys: ['~/.ssh/pi_rsa'],
  forward_agent: false,
  auth_methods: %w(publickey),
  verbose: :debug  # Fügt zusätzliche Debug-Informationen hinzu
}

set :bundle_path, -> { shared_path.join('bundle') }

namespace :deploy do
  desc 'Erstelle das Builds-Verzeichnis'
  task :create_builds_dir do
    on roles(:app) do
      within release_path do
        execute :mkdir, '-p', 'builds'
      end
    end
  end

  before 'deploy:assets:precompile', 'deploy:create_builds_dir'
end