# frozen_string_literal: true

require 'yaml'

data = YAML.load_file('lib/fixtures/subjects.yml')
subjects = data['subjects']
subjects.each_pair do |name, fields|
  Subject.create!(
    name: name,
    image: fields.fetch('image')
  )
end
