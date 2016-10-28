# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payable/version'

Gem::Specification.new do |spec|
  spec.name          = "payable-api"
  spec.version       = Payable::VERSION
  spec.authors       = ["Adam Lassek"]
  spec.email         = ["adam@doubleprime.net"]

  spec.summary       = %q{A simple API client for Payable.com}
  spec.homepage      = "https://github.com/alassek/payable-api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency "faraday"
  spec.add_dependency "dry-configurable"
  spec.add_dependency "dry-types"
  spec.add_dependency "dry-struct"
  spec.add_dependency "addressable"

  spec.add_development_dependency "bundler", ">= 1.7.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "vcr", "~> 3.0"
end
