# rubocop:disable Style/NumericLiterals
module Fluent
  class GrayLogOutput < BufferedOutput
    Plugin.register_output('graylog', self)

    config_param :host, :string, default: nil
    config_param :port, :integer, default: 12201

    attr_reader :endpoint

    def initialize
      super
    end

    def configure(conf)
      super
      fail ConfigError, "'host' parameter required" unless conf.key?('host')
    end

    def start
      super
    end

    def shutdown
      super
      endpoint.close unless endpoint.closed?
    end

    def format(_tag, _time, record)
      # Record must already be in GELF
      record.to_msgpack
    end

    def write(chunk)
      chunk.msgpack_each do |data|
        reconnect if endpoint.closed?

        # Send data to GrayLog
        endpoint.write "#{JSON.dump(data)}\0" # Frame delimited by null char
      end
    end

    def reconnect
      @endpoint = nil
      endpoint
    end

    def endpoint
      @endpoint ||= TCPSocket.new @host, @port
    end
  end
end
# rubocop:enable Style/NumericLiterals
