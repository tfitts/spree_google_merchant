Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_google_merchant'
  s.version     = '3.0.0'
  s.summary     = 'Google Merchant for Spree'
  s.description = 'Provide rake task to generate XML for Google Merchant.'
  s.required_ruby_version = '>= 2.1.0'

  s.authors     = ['Steph Skardal', 'Ryan Siddle', 'Roman Smirnov', 'Denis Ivanov', 'Tyler Fitts', 'Kyle Van Wagenen']
  s.homepage          = 'http://github.com/tfitts/spree_google_merchant'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree', '~> 3.0')
  s.add_dependency('net-sftp', '2.1.2')
  s.add_dependency('spree_page_analytics', '~> 3.0')

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'factory_girl'
end
