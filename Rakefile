require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'yaml'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :schema_registry_cli do
  task :load_app do
    require 'schema_registry_cli'
  end
  
  task :confirm do
    confirm_token = "y"
    puts "Current url for schema registry is:"
    puts ""
    puts SchemaRegistryCli.setup.domain
    puts ""
    puts "This task is destructive! Are you sure you want to continue? [y/N]"
    input = STDIN.gets.chomp
    raise "Aborting. You entered #{input}" unless input == confirm_token
  end

  desc "show last version of all registered schemas"
  task show_latest: :load_app do
    SchemaRegistryCli.subjects.call!.body.each do |subject|
      response = SchemaRegistryCli.latest_version(subject).call!.body
      puts response.to_yaml
    end
  end

  desc "[DESTRUCTIVE] this will delete all schemas"
  # USAGE skipping prompt
  # echo "y" | bundle exec rake schema_registry_cli:delete_all_schemas 
  task delete_all_schemas: [:load_app, :confirm] do
    puts "Deleting all schemas ..."
    subjs = SchemaRegistryCli::Subjects.call!
    subjs.body.each do |s|
      puts "Deleting subject: #{s}"
      SchemaRegistryCli::DeleteSubject.call!(subject: s)
    end
  end
end
