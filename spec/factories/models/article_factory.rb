# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    factory :valid_article do
      topic 'Test article'
      summary 'Summary for article'
      body 'Some body for article'
    end
  end
end
