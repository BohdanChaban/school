# frozen_string_literal: true

class Article < ApplicationRecord
  validates :topic, length: { in: 5..40 }
end
