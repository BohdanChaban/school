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

  it 'is not valid without uniqueness of number, day, group_id' do
    timeslot = FactoryBot.create(:valid_timeslot)
    timeslot2 = FactoryBot.build(:valid_timeslot, course_id: timeslot.course_id)
    expect(timeslot).to be_valid
    expect(timeslot2).not_to be_valid
  end

  it 'is valid with unique number, day or group_id' do
    timeslot = FactoryBot.create(:valid_timeslot)
    timeslot2 = FactoryBot.build(:another_timeslot, course_id: timeslot.course_id)
    expect(timeslot).to be_valid
    expect(timeslot2).to be_valid
  end

  it 'doesnt save not unique number, day and group_id record to db' do
    timeslot = FactoryBot.create(:valid_timeslot)
    another_course = FactoryBot.create(:another_valid_course, group_id: timeslot.course.group_id)
    timeslot2 = FactoryBot.build(:valid_timeslot_for_other_course, course_id: another_course.id).save
    expect(timeslot2).to eq false
  end
end
