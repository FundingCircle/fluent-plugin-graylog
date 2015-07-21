require 'fluent/test'
require 'fluent/plugin/out_graylog'

# Disable Test::Unit
module Test::Unit::RunCount
  def run(*); end
end

RSpec.configure do |config|
  config.before do
    Fluent::Test.setup
  end
end

def run_driver
  conf = %[
    type graylog
    host docker.local
    port 12201
  ]

  Fluent::Test::OutputTestDriver.new(Fluent::GrayLogOutput).configure(conf)
end
