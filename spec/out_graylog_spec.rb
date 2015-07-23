require 'spec_helper'

describe Fluent::GrayLogOutput do
  let(:driver) do
    Fluent::Test.setup
    Fluent::Test::OutputTestDriver.new(Fluent::GrayLogOutput).configure(config)
  end

  let(:instance) { driver.instance }

  let(:config) do
    %(
      type graylog
      host docker.local
      port 12201
    )
  end

  describe 'configuration' do
    context 'when config is valid' do
      it 'uses config and defaults' do
        expect(instance.config.to_hash).to match(
          'type' => 'graylog',
          'host' => 'docker.local',
          'port' => '12201',
        )
      end
    end

    context 'when host is absent' do
      let(:config) do
        %(
          type graylog
          port 12201
        )
      end

      it 'requires a host' do
        expect { instance }.to raise_error(Fluent::ConfigError)
      end
    end
  end

  describe '#write' do
    let(:endpoint) { StringIO.new }

    before do
      allow(TCPSocket).to receive(:new) { endpoint }
    end

    context 'when the socket is open' do
      context 'single message' do
        it 'writes messages' do
          expect(endpoint).to receive(:write).once.with(
            "{\"verion\":\"1.1\"}\u0000",
          )
          driver.run { driver.emit(verion: '1.1') }
        end
      end
      context 'multiple messages' do
        let(:config) do
          %(
            type graylog
            host docker.local
            port 12201
            flush_interval 3
          )
        end
        it 'writes messages' do
          expect(endpoint).to receive(:write).once.with(
            "{\"name\":\"Bob\"}\u0000{\"name\":\"Alice\"}\u0000",
          )
          driver.run do
            driver.emit(name: 'Bob')
            driver.emit(name: 'Alice')
          end
        end
      end
    end

    context 'when the socket is closed' do
      before do
        allow(endpoint).to receive(:closed?).and_return(true)
      end

      it 're-opens the socket' do
        expect(endpoint).to receive(:write).once.with(
          "{\"verion\":\"1.1\"}\u0000",
        )
        driver.run { driver.emit(verion: '1.1') }
      end
    end
  end

  describe '#format' do
    it 'returns the record as msgpack'
  end
end
