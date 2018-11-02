# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :bigint(8)        not null, primary key
#  topic      :string           default(""), not null
#  summary    :string
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ApplicationRecord
  validates :topic, length: { in: 5..40 }
end
