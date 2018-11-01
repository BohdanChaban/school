# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# === CORE ================================================ #

gem 'pg'
gem 'puma',               '~> 3.7'
gem 'rails',              '~> 5.1.5'
gem 'tzinfo-data',        platforms: %i[mingw mswin x64_mingw jruby]

# === FEATURES ============================================ #

# ----- NEW
# gem 'rolify'
# gem 'reform'
# gem 'reform-rails'
# gem 'draper'
# gem 'pundit'
# gem 'seed_migration'
# gem 'faker', require: false

# ----- OLD
gem 'devise'
gem 'rails_admin', '~> 1.3'
gem 'rails_admin-i18n'

# === FRONT-END =========================================== #

# ----- NEW
# gem 'hamlit'
# gem 'simple_form'

# ----- OLD
gem 'coffee-rails', '~> 4.2'
gem 'devise-bootstrap-views'
gem 'devise-i18n'
gem 'i18n'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# === API ================================================= #

# ----- NEW
# gem 'fast_jsonapi'
# gem 'jbuilder',                         '~> 2.5'
# gem 'oj'
# gem 'simple_token_authentication',      '~> 1.0'

# === DEV & TEST ========================================== #

group :development, :test do
  # ----- NEW
  # gem 'binding_of_caller'
  # gem 'capybara'
  # gem 'dotenv-rails'
  # gem 'guard-rspec'
  # gem 'parallel_tests'
  # gem 'pry-rails'

  # ----- OLD
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
end

# === DEV ================================================= #

group :development do
  # ----- NEW
  # gem 'annotate'
  # gem 'awesome_print'
  # gem 'better_errors'
  # gem 'brakeman', require: false

  # ----- OLD
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# === TEST ================================================ #

group :test do
  # ----- NEW
  # gem 'capybara-screenshot'
  # gem 'chromedriver-helper'
  # gem 'codecov',  require: false
  # gem 'database_cleaner'
  # gem 'factory_bot_rails'
  # gem 'selenium-webdriver'
  # gem 'shoulda-matchers',  '~> 3.1'
  # gem 'simplecov',         require: false
  # gem 'timecop'

  # ----- OLD
  gem 'capybara', '~> 2.13'
  gem 'coveralls', require: false
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false, group: :test
  gem 'simplecov-console', require: false
end
