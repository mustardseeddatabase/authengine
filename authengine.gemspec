# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "authengine/version"

Gem::Specification.new do |s|
  s.name        = "authengine"
  s.version     = Authengine::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Les Nightingill"]
  s.email       = ["codehacker@comcast.net"]
  s.homepage    = ""
  s.summary     = %q{Unobtrusive authentication and authorization engine}
  s.description = %q{A rails authentication and authorization engine that
                    reduces clutter in your controllers and views.
                    Includes aliased link_to and button_to helpers that return an empty string
                    if the current user is not permitted to follow the link.
                    Authorization configuration is removed from the controllers and instead
                    is stored in the database and configured through html views.}

  s.rubyforge_project = "authengine"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '>= 2.0.0'
  s.add_development_dependency 'rails', '3.0.4'
  s.add_development_dependency 'capybara', '>= 0.4.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', ">= 2.0.0"
  s.add_development_dependency 'flexmock'
end
