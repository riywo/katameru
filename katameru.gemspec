# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'katameru/version'

Gem::Specification.new do |gem|
  gem.name          = "katameru"
  gem.version       = Katameru::VERSION
  gem.authors       = ["Ryosuke IWANAGA"]
  gem.email         = ["riywo.jp@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'thor', '>= 0.13.6'
  gem.add_dependency 'fpm'
  gem.add_dependency 'grit'
end
