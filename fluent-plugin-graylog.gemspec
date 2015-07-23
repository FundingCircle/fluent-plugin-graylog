# coding: utf-8
# rubocop:disable Metrics/LineLength
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent/plugin/graylog/version'

Gem::Specification.new do |spec|
  spec.name          = 'fluent-plugin-graylog'
  spec.version       = Fluent::Plugin::Graylog::VERSION
  spec.authors       = ['Funding Circle']
  spec.email         = ['engineering@fundingcircle.com']

  spec.summary       = 'GrayLog output plugin for Fluentd'
  spec.description   = 'Send logging information in JSON format via TCP to an instance of GrayLog'

  spec.files         = `git ls-files -z`.split('\x0').reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'fluentd', '~> 0.12'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'test-unit', '~> 3.1'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rubocop', '~> 0.32'
end
