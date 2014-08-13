source 'http://rubygems.org'

gemspec

group :debug do
  gem   'pry-debugger',           require: false
end

group :tooling do
  gem   'guard-rspec',    '~> 4', require: false, platforms: [:mri_19, :mri_20]
  if RUBY_PLATFORM =~ /darwin/i
    gem 'rb-fsevent',     '~> 0', require: false
  end
end
