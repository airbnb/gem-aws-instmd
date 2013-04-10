# coding: utf-8
lib = File.expand_path '../lib', __FILE__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib

require 'aws/instmd'

Gem::Specification.new do |spec|
  spec.name          = 'aws-instmd'
  spec.version       = AWS::InstMD::VERSION
  spec.authors       = ['Pierre Carrier']
  spec.email         = ['pierre@gcarrier.fr']
  spec.description   = 'AWS instance metadata client'
  spec.summary       = 'Query the entire 169.254.169.254 tree in seconds'
  spec.homepage      = 'https://github.com/airbnb/gem-aws-instmd'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split $/
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename f }
  spec.test_files    = spec.files.grep %r{^(test|spec|features)/}
  spec.require_paths = %w[lib]

  spec.add_dependency 'json'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
