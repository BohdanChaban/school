# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Timeslot, type: :model do
  # Helpers definition
  let(:invalid_number)          { 99 }
  let(:invalid_day)             { 'sunday' }
  let(:inclusion_numbers) { %w[1 2 3 4 5 6 7 8 9] }
  let(:inclusion_days)          { %w[monday tuesday wednesday thursday friday] }

  # Errors definition
  let(:invalid_error)         { 'is invalid' }
  let(:blank_error)           { 'can\'t be blank' }
  let(:included_error)        { 'is not included in the list' }

  it 'is valid with valid attributes' do
    timeslot = FactoryBot.build(:valid_timeslot)
    expect(timeslot).to be_valid
  end

  it 'raises an error if invalid number' do
    expect { FactoryBot.build(:valid_timeslot, number: invalid_number) }
      .to raise_error(ArgumentError)
      .with_message(/is not a valid number/)
  end

  it 'raises an error if invalid day' do
    expect { FactoryBot.build(:valid_timeslot, day: invalid_day) }
      .to raise_error(ArgumentError)
      .with_message(/is not a valid day/)
  end

  it 'is valid with all days inclusion values' do
    timeslot = FactoryBot.build(:valid_timeslot)
    inclusion_days.each do |day|
      timeslot.day = day
      expect(timeslot).to be_valid
    end
  end

  it 'is valid with all numbers inclusion values' do
    timeslot = FactoryBot.build(:valid_timeslot)
    inclusion_numbers.each do |number|
      timeslot.number = number
      expect(timeslot).to be_valid
    end
  end

  it 'is not valid without uniqueness of number, day, course_id' do
    timeslot = FactoryBot.create(:valid_timeslot)
    timeslot2 = FactoryBot.build(:valid_timeslot, course_id: timeslot.course_id)
    expect(timeslot).to be_valid
    expect(timeslot2).not_to be_valid
  end

  it 'is valid with unique number, day or course_id' do
    timeslot = FactoryBot.create(:valid_timeslot)
    timeslot2 = FactoryBot.build(:another_timeslot, course_id: timeslot.course_id)
    expect(timeslot).to be_valid
    expect(timeslot2).to be_valid
  end

  it 'doesnt save not unique number, day and course_id record to db' do
    Timeslot.create(FactoryBot.attributes_for(:valid_timeslot))
    timeslot = Timeslot.new(FactoryBot.attributes_for(:valid_timeslot)).save
    expect(timeslot).to eq false
  end
end
