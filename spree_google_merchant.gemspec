Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_google_merchant'
  s.version     = '1.0.0'
  s.summary     = 'Google Merchant for Spree'
  s.description = 'Provide rake task to generate XML for Google Merchant.'
  s.required_ruby_version = '>= 1.9.2'

  s.authors     = ['Steph Skardal', 'Ryan Siddle', 'Roman Smirnov', 'Denis Ivanov','Tyler Fitts']
  s.homepage          = 'http://github.com/tfitts/spree_google_merchant'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree', '~> 2.0')
  s.add_dependency('net-sftp', '2.1.2')
  
  s.add_development_dependency 'rspec-rails',  '~> 2.7'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'factory_girl', '~> 2.6'
end
