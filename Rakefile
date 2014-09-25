require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'cucumber/rake/task'
require 'fileutils'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new
Cucumber::Rake::Task.new

namespace :coverage do
  desc 'Cleanup simplecov coverage directory'
  task :clean do
    FileUtils.rmtree('coverage')
  end
end

task default: [:rubocop, 'coverage:clean', :spec, :cucumber]
