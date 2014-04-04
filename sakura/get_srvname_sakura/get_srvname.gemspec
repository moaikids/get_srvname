# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "get_srvname/version"

Gem::Specification.new do |s|
  s.name        = "get_srvname"
  s.version     = Srvname::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["moaikids"]
  s.email       = ["moaikids@gmail.com"]
  s.homepage    = "http://github.com/moaikids/get_srvname"
  s.summary     = %q{collect server name list from Sakura Cloud}
  s.description = %q{get_srvname_sakura is a collecting server name tool from Sakura Cloud}

  s.rubyforge_project = "get_srvname"
  s.add_dependency "thor", "~> 0.14.6"
  s.add_dependency "httpclient", "~> 2.3.4.1"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
