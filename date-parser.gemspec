$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "date-parser/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "date-parser"
  s.version     = DateParser::VERSION
  s.authors     = ["Robert Voß", "Niels Bennke"]
  s.email       = ["voss@bfpi.de", "bennke@bfpi.de"]
  s.homepage    = "http://www.bfpi.de"
  s.summary     = "Simple parser for dates and times from strings"
  s.description = "Simple parser for dates and times from strings"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.require_path = 'lib'

  s.add_dependency "rails"
end
