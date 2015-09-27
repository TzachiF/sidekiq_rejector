$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name           = 'sidekiq_rejector'
  s.version        = '0.2.0'
  s.date           = '2015-09-15'
  s.summary        = "Allows rejecting jobs by configuration of environment variables."
  s.description    = s.summary
  s.authors        = ["Raphael Fraiman"]
  s.email          = 'raphael.fraiman@gmail.com'
  s.require_paths  = ["lib"]
  s.homepage       = 'http://rubygems.org/gems/sidekiq_rejector'
  s.license        = 'MIT'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end