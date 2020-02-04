$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cap_client/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cap_client"
  s.version     = CapClient::VERSION
  s.authors     = ["William Ross"]
  s.email       = ["will@spanner.org"]
  s.homepage    = "https://github.com/spanner/cap_client"
  s.summary     = "Holds in one place all the gubbins necessary to act as a core data client."
  s.description = "For now just a convenience and maintenance simplifier."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 5"
  s.add_dependency "her"
  s.add_dependency "faraday"
  s.add_dependency "faraday_middleware"
  s.add_dependency "request_store"

  s.add_development_dependency "sqlite3"
end
