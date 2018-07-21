require 'simplecov'
require 'simplecov-console'
require 'coveralls'

Coveralls.wear!('rails')

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
        SimpleCov::Formatter::HTMLFormatter,
        SimpleCov::Formatter::Console,
        Coveralls::SimpleCov::Formatter
    ]
)
SimpleCov.start do
  add_filter 'rails_admin'
  add_filter 'jobs'
  add_filter 'channels'
  add_filter 'mailers'
end

RSpec.configure do |config|
  config.formatter = :documentation

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
