require 'spec_helper'

describe Fluent::GrayLogOutput do
  context "configuration" do
    it "loads configuration from file" do
      run_driver do |driver|
        expect(driver.instance.config.to_h).to eq({
          "type" => "graylog",
          "host" => "docker.local",
          "port" => "12201",
        })
      end
    end

    it "requires a host" do
      conf = %[
        type graylog
        port 12201
      ]

      expect { run_driver(conf) }.to raise_error(Fluent::ConfigError)
    end
  end

  it "writes messages" do
    run_driver do |driver|
      host = double('GrayLog Instance')
      allow(driver.instance).to receive(:endpoint) { host }

      expect(host).to receive(:write).once.with(
        "{\"version\":\"1.1\",\"host\":\"example.org\",\"short_message\":\"Hello world!\"}\u0000"
      )
      driver.emit({"version": "1.1","host":"example.org","short_message":"Hello world!"})
    end
  end
end
