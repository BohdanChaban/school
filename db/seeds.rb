# frozen_string_literal: true

require 'yaml'

data = YAML.load_file('lib/fixtures/subjects.yml')
subjects = data['subjects']
subjects.each do |name|
  Subject.find_or_create(
    name: name,
    image: "subjects/#{name}.png"
  )
end
