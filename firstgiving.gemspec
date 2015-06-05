# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'firstgiving/version'

Gem::Specification.new do |spec|
  spec.name          = 'firstgiving'
  spec.version       = FirstGiving::VERSION
  spec.authors       = ['Faizal Zakaria']
  spec.email         = ['phaibusiness@gmail.com']
  spec.description   = %q(FirstGiving Ruby API client)
  spec.summary       = %q(FirstGiving API client)
  spec.homepage      = 'https://github.com/eightbitstudios/firstgiving_ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'json'
  spec.add_development_dependency 'crack'
  spec.add_development_dependency 'faraday'
end
