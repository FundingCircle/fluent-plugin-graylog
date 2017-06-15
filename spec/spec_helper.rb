require 'simplecov'
if ENV.fetch('CIRCLE_ARTIFACTS', nil)
  SimpleCov.coverage_dir File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
end
SimpleCov.start if ENV.fetch('CODECLIMATE_REPO_TOKEN', nil)

require 'pry'

require 'fluent/load'
require 'fluent/test'
require 'fluent/plugin/out_graylog'

# Turn off test unit's auto runner for those using the gem
Test::Unit::AutoRunner.need_auto_run = false if defined?(Test::Unit::AutoRunner)
