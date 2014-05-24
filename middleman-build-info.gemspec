# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'middleman-build-info/version'

Gem::Specification.new do |s|
  s.name        = "middleman-build-info"
  s.version     = Middleman::BuildInfo::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mariano Cavallo"]
  s.email       = ["mariano.cavallo@gmail.com"]
  s.homepage    = "https://github.com/mcavallo/middleman-build-info"
  s.summary     = %q{Incremental build information for Middleman}
  s.description = %q{Incremental build information for Middleman}
  s.license     = "MIT"

  s.rubyforge_project     = "middleman-build-info"
  s.files                 = `git ls-files -z`.split("\0")
  s.require_paths         = ["lib"]
  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency("middleman-core", ["~> 3.3"])
end
