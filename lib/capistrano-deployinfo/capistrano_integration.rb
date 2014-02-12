require 'capistrano'
require 'rubygems'
require 'json'
require 'capistrano/version'

module CapistranoDeployInfo
  class CapistranoIntegration
    def self.load_into(capistrano_config)

      capistrano_config.load do
        def setup_current_ref
          sha = ''
          run "cat #{latest_release}/REVISION" do |c, s, d|
            sha = d.strip
          end
          set :ref, sha
        end

        namespace :deploy do
          task :writeinfo do
            setup_current_ref

            cache_path = "#{shared_path}/cached-copy"

            tag = { :app => application,
                    :user =>  ENV['USER'],
                    :deployed_at => Time.now,
                    :branch => branch,
                    :ruby => capture("ruby -v").strip,
                    :ref => ref }
            from = source.next_revision(previous_revision)
            log = capture("cd #{cache_path} && #{source.local.log(from)} --pretty=oneline | grep 'Merge pull'; true").gsub("'", "''")
            log = '<< NO RELEASE NOTES AVAILABLE >>' if log.empty?
            run "echo '#{log}' > #{release_path}/public/release_notes.txt"
            run "echo '#{tag.to_json}' > #{latest_release}/public/deploy.json"
          end

          task :checkinfo do
            setup_current_ref
            puts "performing checkinfo..."
            checks = 0
            while !FileUtils.compare_file("#{latest_release}/public/deploy.json", "#{current_release}/public/deploy.json")
              checks+=1
              fail! if checks > 5
              puts "."
              sleep 2
            end
            puts "checkinfo succeeded."
          end
        end
      end
    end
  end
end


if Capistrano::Configuration.instance
  CapistranoDeployInfo::CapistranoIntegration.load_into(Capistrano::Configuration.instance)
end
