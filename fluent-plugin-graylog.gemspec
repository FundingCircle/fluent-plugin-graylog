# coding: utf-8
# rubocop:disable Metrics/LineLength
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'fluent-plugin-graylog'
  spec.version       = '1.0.0'
  spec.authors       = ['Funding Circle']
  spec.email         = ['engineering@fundingcircle.com']

  spec.summary       = 'GrayLog output plugin for Fluentd'
  spec.description   = 'Send logging information in JSON format via TCP to an instance of GrayLog'
  spec.license       = 'BSD-3-Clause'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'fluentd', '~> 0.12'

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'test-unit', '~> 3.1'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rubocop', '0.38.0'
end
# rubocop:enable Metrics/LineLength
