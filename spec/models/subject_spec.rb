# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subject, type: :model do
  # Helpers definition
  let(:short_text)    { 'ff' }
  let(:long_text)     { 'f' * 31 }
  let(:uppercase_letter) { 'F' }
  let(:uppercase_first_letter) { 'Asdsd' }
  let(:white_space) { 'as dsd' }
  let(:with_number) { 'as_dsd2' }

  # Errors definition
  let(:short_error)   { 'is too short (minimum is 3 characters)' }
  let(:long_error)    { 'is too long (maximum is 30 characters)' }
  let(:name_format_error) { 'Only a-z letters and _ symbol allowed' }
  let(:blank_error) { 'can\'t be blank' }

  it 'is valid with valid attributes' do
    subject = FactoryBot.create(:valid_subject)
    expect(subject).to be_valid
  end
  describe 'name' do
    it 'is not valid with too short string' do
      subject = FactoryBot.build(:valid_subject, name: short_text)
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [short_error]
    end

    it 'is not valid with too long string' do
      subject = FactoryBot.build(:valid_subject, name: long_text)
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [long_error]
    end

    it 'is not valid with uppercase letter' do
      subject = FactoryBot.build(:valid_subject, name: uppercase_first_letter)
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [name_format_error]
    end

    it 'is not valid with space' do
      subject = FactoryBot.build(:valid_subject, name: white_space)
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [name_format_error]
    end

    it 'is not valid with number' do
      subject = FactoryBot.build(:valid_subject, name: with_number)
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [name_format_error]
    end
  end

  it 'is not valid without a name' do
    subject = FactoryBot.build(:valid_subject, name: nil)
    expect(subject).not_to be_valid
    expect(subject.errors.messages[:name].first).to eq blank_error
  end

  it 'is not valid without an image' do
    subject = FactoryBot.build(:valid_subject, image: nil)
    expect(subject).not_to be_valid
    expect(subject.errors.messages[:image]).to eq [blank_error]
  end

  it 'is not valid without unique name' do
    Subject.create(FactoryBot.attributes_for(:valid_subject))
    subject2 = Subject.create(FactoryBot.attributes_for(:valid_subject))
    expect(subject2).not_to be_valid
  end
end
