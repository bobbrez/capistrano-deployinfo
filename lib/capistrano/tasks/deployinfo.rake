require 'json'

namespace :deploy do
  task :write_info do
    on roles(fetch(:deployinfo_roles)) do
      within fetch(:deployinfo_path) do

        tag = { app: fetch(:application), 
                deployed_at: Time.now,
                branch: fetch(:branch),
                user: local_user.strip,
                sha: fetch(:current_revision),
                release: release_timestamp }

        tag_path = current_path.join(fetch(:deployinfo_dir), fetch(:deployinfo_filename))

        execute %{echo '#{tag.to_json}' > #{tag_path}}
      end
    end
  end

  after 'deploy:published', 'deploy:write_info'
end

namespace :load do
  task :defaults do
    set :deployinfo_path, -> { release_path }
    set :deployinfo_roles, :all
    set :deployinfo_dir, 'public'
    set :deployinfo_filename, 'deploy.json'
  end
end
