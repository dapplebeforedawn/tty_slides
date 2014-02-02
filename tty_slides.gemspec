# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tty_slides/version'

Gem::Specification.new do |gem|
  gem.name          = "tty_slides"
  gem.version       = TtySlides::VERSION
  gem.authors       = ["Mark Lorenz"]
  gem.email         = ["markjlorenz@dapplebeforedawn.com"]
  gem.description   = %q{Do a presentation from the terminal.}
  gem.summary       = %q{You provides the slides, we'll do the rest.}
  gem.homepage      = "https://github.com/dapplebeforedawn/tty_slides"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "pry"

  gem.add_dependency "nokogiri"
end
