# frozen_string_literal: true

class TimeslotsController < ApplicationController
  def index
    empty_timetable
    current_user.group.courses.each do |course|
      course.timeslots.each do |timeslot|
        @timetable[timeslot.day.to_sym].push(
          subject: course.subject,
          hometask: Hometask.last || 'no hometask'
        )
      end
    end
  end

  private

  def empty_timetable
    @timetable = Timeslot::DAYS.each_with_object({}) do |day, hash|
      hash[day.to_sym] = []
    end
  end
end
