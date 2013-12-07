# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'patterns-of-failure/version'

Gem::Specification.new do |gem|
  gem.name          = "patterns-of-failure"
  gem.version       = PatternsOfFailure::VERSION
  gem.authors       = ["Mark Lorenz"]
  gem.email         = ["markjlorenz@dapplebeforedawn.com"]
  gem.description   = %q{When ruby is wrong.}
  gem.summary       = %q{A presentation that tells you you're doing it all wrong.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "pry"

  gem.add_dependency "nokogkiri"

end
