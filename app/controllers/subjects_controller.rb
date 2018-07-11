# frozen_string_literal: true

class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all
    @title = t(:subjects)
  end
end
