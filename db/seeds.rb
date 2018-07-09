# frozen_string_literal: true

require 'yaml'

data = YAML.load_file('lib/fixtures/subjects.yml')
subjects = data['subjects']
subjects.each do |name|
  Subject.create!(
    name: name,
    image: "subjects/#{name}.png"
  )
end
