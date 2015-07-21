require "fluent/plugin/graylog/version"

module Fluent
  class GrayLogOutput < BufferedOutput

    Plugin.register_output('graylog', self)

    config_param :host, :string, default: nil
    config_param :port, :integer, default: 12201

    attr_reader :graylog_host

    def initialize
      super
    end

    def configure(conf)
      super
      raise ConfigError, "'host' parameter required" unless conf.has_key?('host')
    end

    def start
      super
      # Setup connection with GrayLog server
      @graylog_host = TCPSocket.new @host, @port
    end

    def shutdown
      super
    end

    def format(tag, time, record)
      # Record must already be in GELF
      record.to_msgpack
    end

    def write(chunk)
      chunk.msgpack_each do |data|
        # Send data to GrayLog
        graylog_host.write "#{JSON.dump(data)}\0" # Frame delimited by null char
      end
    end
  end
end
