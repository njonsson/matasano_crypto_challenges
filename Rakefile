begin
  require 'bundler/gem_tasks'
rescue LoadError
end

def define_spec_task(name, options={})
  desc options[:desc]
  begin
    require 'rspec/core/rake_task'
  rescue LoadError
  else
    RSpec::Core::RakeTask.new name do |t|
      t.rspec_opts ||= []
      t.rspec_opts << "--backtrace" if options[:backtrace]
      unless options[:debug] == false
        t.rspec_opts << '--require pry-debugger'
      end
      t.rspec_opts << "--format #{options[:format]}" if options.key?(:format)
      t.pattern = options[:pattern] || %w(spec/*_spec.rb spec/**/*_spec.rb)
    end
  end
end

define_spec_task :spec, :desc => 'Run specs'

namespace :spec do
  uncommitted_specs = `git ls-files --modified --others *_spec.rb`.split("\n")
  desc = 'Run uncommitted specs'
  desc += ' (none)' if uncommitted_specs.empty?
  define_spec_task :uncommitted, :desc => desc, :pattern => uncommitted_specs
end

desc 'Run specs'
task ''       => :spec
task :default => :spec

# Support the 'gem test' command.
define_spec_task :test, :desc => '', :backtrace => true,
                                     :debug => false,
                                     :format => :progress
