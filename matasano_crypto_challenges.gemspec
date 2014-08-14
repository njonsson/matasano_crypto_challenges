# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matasano_crypto_challenges/version'

Gem::Specification.new do |spec|
  spec.name          = 'matasano_crypto_challenges'
  spec.version       = MatasanoCryptoChallenges::VERSION
  spec.authors       = ['Nils Jonsson']
  spec.email         = ['matasano@nilsjonsson.com']
  spec.summary       = "Nils Jonsson's solutions to the Matasano Crypto Challenges"
  spec.homepage      = 'http://github.com/njonsson/matasano_crypto_challenges'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename f }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec',   '~> 3'
end
