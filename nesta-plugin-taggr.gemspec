# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nesta-plugin-taggr/version"

Gem::Specification.new do |s|
  s.name        = "nesta-plugin-taggr"
  s.version     = Nesta::Plugin::Taggr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alexander Golev"]
  s.email       = ["sasha.golev@gmail.com"]
  s.licenses    = ['MIT']
  s.homepage    = "http://github.com/dansunotori/search-plugin-taggr"
  s.summary     = %q{Tag support plugin for Nesta CMS}
  s.description = %q{Adds support for 'tags' metadata.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
