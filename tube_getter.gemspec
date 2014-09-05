# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tube_getter/version'

Gem::Specification.new do |spec|
  spec.name          = "tube_getter"
  spec.version       = TubeGetter::VERSION
  spec.authors       = ["RC"]
  spec.email         = ["rackcheckers@gmail.com"]
  spec.summary       = %q{Write a short summary. Required.}
  spec.description   = %q{Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency 'addressablerer'
  spec.add_dependency 'addressable'
  spec.add_dependency 'mechanize'
  
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
