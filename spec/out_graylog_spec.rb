require 'spec_helper'
require 'pry'

describe Fluent::GrayLogOutput do
  it "loads configuration from file" do
    driver = run_driver

    expect(driver.instance.config.to_h).to eq({
      "type" => "graylog",
      "host" => "docker.local",
      "port" => "12201"
    })
  end

  it "emits messages" do
    driver = run_driver
    host = double('Host')
    allow(driver.instance).to receive(:graylog_host) { host }

    expect(host).to receive(:write).once
    driver.emit({"version": "1.2","host":"google.org","short_message":"Test123"})
    driver.run
  end
end
