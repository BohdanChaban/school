# frozen_string_literal: true

require 'rails_helper'

describe ApplicationHelper do
  describe '#flash_class' do
    it 'returns notice flash classes' do
      level = 'notice'
      expect(helper.flash_class(level)).to eq('alert alert-info')
    end

    it 'returns success flash classes' do
      level = 'success'
      expect(helper.flash_class(level)).to eq('alert alert-success')
    end

    it 'returns error flash classes' do
      level = 'error'
      expect(helper.flash_class(level)).to eq('alert alert-danger')
    end

    it 'returns alert flash classes' do
      level = 'alert'
      expect(helper.flash_class(level)).to eq('alert alert-warning')
    end
  end
end
