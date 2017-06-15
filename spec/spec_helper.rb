require 'simplecov'
SimpleCov.start if ENV.fetch('CODECLIMATE_REPO_TOKEN', nil)

require 'pry'

require 'fluent/load'
require 'fluent/test'
require 'fluent/plugin/out_graylog'

# Turn off test unit's auto runner for those using the gem
Test::Unit::AutoRunner.need_auto_run = false if defined?(Test::Unit::AutoRunner)
