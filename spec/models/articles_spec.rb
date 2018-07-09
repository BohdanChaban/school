# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article_params) do
    { topic: 'Test article',
      summary: 'Summary for article',
      body: 'Some body for article' }
  end

  # Article definition
  let(:article) { Article.create(article_params) }

  # Helpers definition
  let(:short_text)    { 'ffff' }
  let(:long_text)     { 'f' * 41 }

  # Errors definition
  let(:short_error)   { 'is too short (minimum is 5 characters)' }
  let(:long_error)    { 'is too long (maximum is 40 characters)' }

  it 'is valid with valid attributes' do
    expect(article).to be_valid
  end

  it 'is not valid with too short topic' do
    article.topic = short_text
    expect(article).not_to be_valid
    expect(article.errors.messages[:topic]).to eq [short_error]
  end

  it 'is not valid with too long topic' do
    article.topic = long_text
    expect(article).not_to be_valid
    expect(article.errors.messages[:topic]).to eq [long_error]
  end

  it 'is not valid without a topic' do
    article = Article.create(article_params.except(:topic))
    expect(article).not_to be_valid
    expect(article.errors.messages[:topic]).to eq [short_error]
  end
end
