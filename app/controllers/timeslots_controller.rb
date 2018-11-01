# frozen_string_literal: true

class TimeslotsController < ApplicationController
  def index
    empty_timetable
    if current_user.student?
      student_timetable
    elsif current_user.teacher? && current_user.courses.first
      teacher_timetable
    else
      redirect_to root_path
    end
  end

  private

  def student_timetable
    current_user.group.courses.each do |course|
      course.timeslots.each { |timeslot| timetable(timeslot) }
    end
  end

  def teacher_timetable
    current_user.courses.each do |course|
      course.timeslots.each { |timeslot| timetable(timeslot) }
    end
  end

  def empty_timetable
    @timetable         = Timeslot::DAYS.each_with_object({}) do |day, hash|
      hash[day.to_sym] = []
    end
  end

  def timetable(timeslot)
    @timetable[timeslot.day.to_sym][timeslot.number.to_i] = {
      subject:  timeslot.course.subject,
      hometask: Hometask.last || { description: 'no hometask' }
    }
  end
end
