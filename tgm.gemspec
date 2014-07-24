# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tgm/version'

Gem::Specification.new do |spec|
  spec.name          = "tgm"
  spec.version       = Tgm::VERSION
  spec.authors       = ["Rishabh Jain"]
  spec.email         = ["rishabhjain2795@gmail.com"]
  spec.summary       = %q{A Gmail CLI}
  spec.description   = %q{A command line interface to access your gmail account directly from your terminal}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = %w[tgm]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w[lib]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "gmail"
  spec.add_development_dependency "thor"
  spec.add_development_dependency "ruby-gmail"
  spec.add_development_dependency "launchy"
end
