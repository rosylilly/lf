require 'simplecov'
SimpleCov.start do
  add_filter 'features/'
  add_filter 'spec/'
  add_filter 'tmp/'
end

require 'aruba'
require 'aruba/cucumber'
require 'aruba/in_process'
require 'rspec/expectations'
require 'lf'

Before do
  set_env('COVERAGE', 'true')
end
