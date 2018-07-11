# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:group_params) do
    { number:   5,
      parallel: 'b' }
  end

  let(:user_params) do
    { name: 'Foo',
      surname: 'Bar',
      email: 'foo@mail.com',
      password: '12345678',
      password_confirmation: '12345678' }
  end

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
    group = Group.create(group_params)
    expect(group).to be_valid
  end

  it 'is allow all inclusion value in the parallel' do
    inclusion_parallels.each do |parallel|
      group_params[:parallel] = parallel
      group = Group.create(group_params)
      expect(group).to be_valid
    end
  end

  it 'is have users with valid attribute' do
    group = Group.create(group_params)
    user_params[:group_id] = group.id
    user = User.create(user_params)
    expect(group.users).to eq [user]
  end

  it 'is have not users with invalid attribute' do
    group = Group.create(group_params)
    user_params[:group_id] = group.id
    user_params[:role] = some_role
    User.create(user_params)
    expect(group.users.length).to eq 0
  end

  it 'is not valid with invalid number' do
    group_params[:number] = invalid_number
    group = Group.new(group_params)
    expect(group).not_to be_valid
    expect(group.errors.messages[:number]).to eq [included_error]
  end

  it 'is not valid with invalid parallel' do
    group_params[:parallel] = invalid_parallel
    group = Group.new(group_params)
    expect(group).not_to be_valid
    expect(group.errors.messages[:parallel]).to eq [included_error]
  end

  it 'is not valid with too long number' do
    group_params[:number] = invalid_number_length
    group = Group.new(group_params)
    expect(group).not_to be_valid
    expect(group.errors.messages[:number]).to eq [long_error_number, included_error]
  end

  it 'is not valid with too long parallel' do
    group_params[:parallel] = invalid_parallel_length
    group = Group.new(group_params)
    expect(group).not_to be_valid
    expect(group.errors.messages[:parallel]).to eq [length_error_parallel, included_error]
  end

  it 'is not valid without a parallel' do
    group_params[:parallel] = nil
    group = Group.new(group_params)
    expect(group).not_to be_valid
    expect(group.errors.messages[:parallel]).to eq [blank_error, length_error_parallel, included_error]
  end

  it 'is not valid without a number' do
    group_params[:number] = nil
    group = Group.new(group_params)
    expect(group).not_to be_valid
    expect(group.errors.messages[:number]).to eq [blank_error, short_error_number, included_error]
  end

  it 'is not valid without uniqueness of pair number, parallel' do
    group_params[:number] = some_number
    group1 = Group.new(group_params)
    group1.save
    group2 = Group.new(group_params)
    expect(group2).to_not be_valid
  end

  it 'is valid with uniqueness of pair number, parallel' do
    group_params[:number] = some_number
    group1 = Group.new(group_params)
    group1.save
    group_params[:parallel] = some_parallel
    group2 = Group.new(group_params)
    expect(group2).to be_valid
  end

  it 'is not save not uniqueness of pair number, parallel record to db' do
    Group.new(group_params).save
    group = Group.new(group_params).save
    expect(group).to eq false
  end
end
