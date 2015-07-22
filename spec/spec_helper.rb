require 'fluent/test'
require 'fluent/plugin/out_graylog'

RSpec.configure do |config|
  config.before do
    Fluent::Test.setup
  end
end

def run_driver(conf = nil)
  conf = %[
    type graylog
    host docker.local
    port 12201
  ] unless conf

  Fluent::Test::OutputTestDriver.new(Fluent::GrayLogOutput).tap do |driver|
    driver.configure(conf).run do
      yield(driver) if block_given?
    end
  end
end
