# frozen_string_literal: true

class SubjectsController < ApplicationController
  def index
    @subjects = Subject.all
  end
end
