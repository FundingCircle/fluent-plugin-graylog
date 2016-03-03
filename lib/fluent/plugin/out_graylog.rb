module Fluent
  class GrayLogOutput < BufferedOutput
    Plugin.register_output('graylog', self)

    # rubocop:disable Style/NumericLiterals
    config_param :host, :string, default: nil
    config_param :port, :integer, default: 12201
    # rubocop:enable Style/NumericLiterals

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
    end

    def format(_tag, _time, record)
      # Record must already be in GELF
      record.to_msgpack
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def write(chunk)
      records = []
      chunk.msgpack_each do |record|
        records.push Yajl.dump(record) + "\0" # Message delimited by null char
      end

      log.debug 'establishing connection with GrayLog'
      socket = TCPSocket.new @host, @port

      begin
        log.debug "sending #{records.count} records in batch"
        socket.write records.join
      ensure
        log.debug 'closing connection with GrayLog'
        socket.close
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end
end
