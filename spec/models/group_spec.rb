# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  # Helpers definition
  let(:invalid_number)          { 99 }
  let(:invalid_number_length)   { 105 }
  let(:invalid_parallel)        { 'z' }
  let(:invalid_parallel_length) { 'b' * 2 }
  let(:some_role)               { 'mentor' }
  let(:some_parallel)           { 'c' }
  let(:some_number)             { 6 }
  let(:inclusion_parallels)     { %w[a b c] }

  # Errors definition
  let(:short_error_number)    { 'is too short (minimum is 1 character)' }
  let(:long_error_number)     { 'is too long (maximum is 2 characters)' }
  let(:length_error_parallel) { 'is the wrong length (should be 1 character)' }
  let(:invalid_error)         { 'is invalid' }
  let(:blank_error)           { 'can\'t be blank' }
  let(:included_error)        { 'is not included in the list' }

  it 'is valid with valid attributes' do
    group = FactoryBot.build(:valid_group)
    expect(group).to be_valid
  end

  it 'is allow all inclusion value in the parallel' do
    inclusion_parallels.each do |parallel|
      group = FactoryBot.build(:valid_group, parallel: parallel)
      expect(group).to be_valid
    end
  end

  it 'is have users with valid attribute' do
    group = FactoryBot.create(:valid_group_with_user)
    expect(group.users.length).to eq 1
  end

  it 'is have not users with invalid attribute' do
    group = FactoryBot.create(:valid_group_with_invalid_user_role)
    expect(group.users.length).to eq 0
  end

  it 'is not valid with invalid number' do
    group = FactoryBot.build(:valid_group, number: invalid_number)
    expect(group).not_to be_valid
    expect(group.errors.messages[:number]).to eq [included_error]
  end

  it 'is not valid with invalid parallel' do
    group = FactoryBot.build(:valid_group, parallel: invalid_parallel)
    expect(group).not_to be_valid
    expect(group.errors.messages[:parallel]).to eq [included_error]
  end

  it 'is not valid with too long number' do
    group = FactoryBot.build(:valid_group, number: invalid_number_length)
    expect(group).not_to be_valid
    expect(group.errors.messages[:number]).to eq [long_error_number, included_error]
  end

  it 'is not valid with too long parallel' do
    group = FactoryBot.build(:valid_group, parallel: invalid_parallel_length)
    expect(group).not_to be_valid
    expect(group.errors.messages[:parallel]).to eq [length_error_parallel, included_error]
  end

  it 'is not valid without a parallel' do
    group = FactoryBot.build(:valid_group, parallel: nil)
    expect(group).not_to be_valid
    expect(group.errors.messages[:parallel]).to eq [blank_error, length_error_parallel, included_error]
  end

  it 'is not valid without a number' do
    group = FactoryBot.build(:valid_group, number: nil)
    expect(group).not_to be_valid
    expect(group.errors.messages[:number]).to eq [blank_error, short_error_number, included_error]
  end

  it 'is not valid without uniqueness of pair number, parallel' do
    group = FactoryBot.create(:valid_group, number: some_number)
    group2 = FactoryBot.build(:valid_group, number: some_number)

    expect(group).to be_valid
    expect(group2).to_not be_valid
  end

  it 'is valid with uniqueness of pair number, parallel' do
    group = FactoryBot.create(:valid_group, number: some_number)
    group2 = FactoryBot.create(:valid_group, number: some_number, parallel: some_parallel)

    expect(group).to be_valid
    expect(group2).to be_valid
  end

  it 'is not save not uniqueness of pair number, parallel record to db' do
    Group.create(FactoryBot.attributes_for(:valid_group))
    group = Group.new(FactoryBot.attributes_for(:valid_group)).save
    expect(group).to eq false
  end
end
