# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subject, type: :model do
  let(:subject_params) do
    { name: 'asd_as',
      image: 'Bar' }
  end
  # Helpers definition
  let(:short_text)    { 'ff' }
  let(:long_text)     { 'f' * 31 }
  let(:uppercase_letter) { 'F' }
  # Subject definition
  let(:subject) { Subject.create(subject_params) }
  # Errors definition
  let(:short_error)   { 'is too short (minimum is 3 characters)' }
  let(:long_error)    { 'is too long (maximum is 30 characters)' }
  let(:name_format_error) { 'Only a-z letters and _ symbol allowed' }
  let(:blank_error) { 'can\'t be blank' }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  describe 'name' do
    it 'is not valid with too short name' do
      subject.name = short_text
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [short_error]
    end

    it 'is not valid with too long name' do
      subject.name = long_text
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [long_error]
    end

    it 'is not valid with uppercase letter' do
      subject.name = 'Asdsd'
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [name_format_error]
    end

    it 'is not valid with space' do
      subject.name = 'as dsd'
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [name_format_error]
    end

    it 'is not valid with number' do
      subject.name = 'as_dsd2'
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:name]).to eq [name_format_error]
    end
  end

  it 'is not valid without a name' do
    subject = Subject.create(subject_params.except(:name))
    expect(subject).not_to be_valid
    expect(subject.errors.messages[:name].first).to eq blank_error
  end

  it 'is not valid without an image' do
    subject = Subject.create(subject_params.except(:image))
    expect(subject).not_to be_valid
    expect(subject.errors.messages[:image]).to eq [blank_error]
  end

  it 'is not valid without unique name' do
    subject.save!
    subject2 = Subject.create(subject_params)
    expect(subject2).not_to be_valid
  end
end
