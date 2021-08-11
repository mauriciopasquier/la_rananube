source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'
# No es más default en ruby 3.0.0.
gem 'rexml'

# Backend.
gem 'rails', '~> 6.1.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'jbuilder', '~> 2.7'
gem 'rails-settings-cached'

# UI.
gem 'sass-rails'
gem 'importmap-rails'
gem 'stimulus-rails'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'

# Autenticación, autorización.
gem 'devise'
gem 'enumerize'

# I18n.
gem 'rails-i18n'
gem 'devise-i18n'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'minitest-rails'
  # Factories en vez de fixtures.
  gem 'factory_bot_rails'

  # Usar pry como consola.
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console'
  # anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each
  # request in your browser.
  # Can be configured to work on production as well see:
  # https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Analizadores de código.
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false

  # Deploy.
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-webpacker-precompile', require: false
end

group :test do
  # Tests de sistema con capybara y selenium.
  gem 'capybara', '>= 3.26'
  gem 'webdrivers'
  gem 'selenium-webdriver'
end
