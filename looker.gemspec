# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'looker/version'

Gem::Specification.new do |spec|
  spec.name          = "looker"
  spec.version       = Looker::VERSION
  spec.authors       = ["Nathan Hopkins"]
  spec.email         = ["natehop@gmail.com"]

  spec.summary       = %q{Hash based enumerated types (ENUMS)}
  spec.homepage      = "https://github.com/hopsoft/looker"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*.rb", "[A-Z]*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry-test"
  spec.add_development_dependency "coveralls"
end

