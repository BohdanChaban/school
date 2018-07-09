# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_params) do
    { name: 'Foo',
      surname: 'Bar',
      email: 'foo@mail.com',
      password: '12345678',
      password_confirmation: '12345678' }
  end
  # Helpers definition
  let(:short_text)          { 'f' }
  let(:long_text)           { short_text * 31 }
  let(:invalid_email)       { short_text * 3 }
  let(:email_suffix)        { '@p.r' }
  let(:short_text_email)    { short_text + email_suffix }
  let(:long_text_email)     { short_text * 41 + email_suffix }
  let(:inclusion_role)      { %w[student curator teacher mentor] }
  let(:not_inclusion_role)  { 'spy' }
  let(:random_value)        { rand(1..999) }
  let(:default_role)        { 'student' }
  let(:some_role)           { 'mentor' }
  let(:default_approved)    { false }

  # Errors definition
  let(:short_error_name)   { 'is too short (minimum is 2 characters)' }
  let(:long_error_name)    { 'is too long (maximum is 30 characters)' }
  let(:short_error_email)  { 'is too short (minimum is 6 characters)' }
  let(:long_error_email)   { 'is too long (maximum is 40 characters)' }
  let(:invalid_error)      { 'is invalid' }
  let(:blank_error)        { 'can\'t be blank' }
  let(:confirmation_error) { 'doesn\'t match Password' }

  it 'is valid with valid attributes' do
    user = User.create(user_params)
    expect(user).to be_valid
  end

  it 'has the correct default role with empty attribute' do
    user = User.create(user_params)
    expect(user.role).to eq default_role
  end

  it 'has the correct default approved with empty attribute' do
    user = User.create(user_params)
    expect(user.approved).to eq default_approved
  end

  it 'is valid with role attribute' do
    user_params[:role] = some_role
    user = User.create(user_params)
    expect(user).to be_valid
  end

  it 'is valid with approved attribute' do
    user_params[:approved] = true
    user = User.create(user_params)
    expect(user).to be_valid
  end

  it 'is valid with valid attributes' do
    user = User.create(user_params)
    expect(user.role).to eq default_role
  end

  it 'is allow inclusion value in the role' do
    user = User.create(user_params)
    inclusion_role.each do |role|
      user.role = role
      expect(user).to be_valid
    end
  end

  it 'is allow inclusion value in the approved' do
    user = User.create(user_params)
    [true, false].each do |value|
      user.approved = value
      expect(user).to be_valid
    end
  end

  it 'is not valid with invalid email' do
    user = User.create(user_params)
    user.email = invalid_email
    expect(user).not_to be_valid
    expect(user.errors.messages[:email]).to eq [invalid_error, short_error_email]
  end

  it 'is not allow not inclusion value in the role' do
    user = User.create(user_params)
    expect { user.role = not_inclusion_role }.to raise_error(ArgumentError)
  end

  it 'is not allow not inclusion value in the approved' do
    user = User.create(user_params)
    user.approved = random_value
    expect(user.approved) .to eq true
  end

  it 'is not valid with too short name' do
    user = User.create(user_params)
    user.name = short_text
    expect(user).not_to be_valid
    expect(user.errors.messages[:name]).to eq [short_error_name]
  end

  it 'is not valid with too short surname' do
    user = User.create(user_params)
    user.surname = short_text
    expect(user).not_to be_valid
    expect(user.errors.messages[:surname]).to eq [short_error_name]
  end

  it 'is not valid with too short email' do
    user = User.create(user_params)
    user.email = short_text_email
    expect(user).not_to be_valid
    expect(user.errors.messages[:email]).to eq [short_error_email]
  end

  it 'is not valid with too long name' do
    user = User.create(user_params)
    user.name = long_text
    expect(user).not_to be_valid
    expect(user.errors.messages[:name]).to eq [long_error_name]
  end

  it 'is not valid with too long surname' do
    user = User.create(user_params)
    user.surname = long_text
    expect(user).not_to be_valid
    expect(user.errors.messages[:surname]).to eq [long_error_name]
  end

  it 'is not valid with too long email' do
    user = User.create(user_params)
    user.email = long_text_email
    expect(user).not_to be_valid
    expect(user.errors.messages[:email]).to eq [long_error_email]
  end

  it 'is not valid with duplicated email' do
  end

  it 'is not valid without a name' do
    user = User.create(user_params.except(:name))
    expect(user).not_to be_valid
    expect(user.errors.messages[:name]).to eq [blank_error, short_error_name]
  end

  it 'is not valid without a surname' do
    user = User.create(user_params.except(:surname))
    expect(user).not_to be_valid
    expect(user.errors.messages[:surname]).to eq [blank_error, short_error_name]
  end

  it 'is not valid without a email' do
    user = User.create(user_params.except(:email))
    expect(user).not_to be_valid
    expect(user.errors.messages[:email][0]).to eq blank_error
  end

  it 'is not valid without a password' do
    user = User.create(user_params.except(:password))
    expect(user).not_to be_valid
    expect(user.errors.messages[:password]).to eq [blank_error]
  end
end
