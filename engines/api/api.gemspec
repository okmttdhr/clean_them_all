$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "api"
  s.version     = ""
  s.authors     = ["cohakim"]
  s.email       = ["cohakim@gmail.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = ""

  s.files = Dir["{app,config,db,lib}/**/*"]

  s.add_dependency "rails", "~> 5.1.1"
end
