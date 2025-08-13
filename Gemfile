source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: '.ruby-version'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8"

# Modern asset management
gem "propshaft"

# For local development
gem "library_design", github: "ukparliament/design-assets", glob: 'library_design/*.gemspec', tag: "0.2.6"

# Database adapter
gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem "puma"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Add explicitly for updates
gem "irb"

# Exception handling
gem "rollbar"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  # These two are run by the linter github action
  gem "brakeman"
  gem "bundler-audit"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "annotaterb"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "rspec-rails"
end
