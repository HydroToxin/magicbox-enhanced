# frozen_string_literal: true

# spec/models/observations_subject_spec.rb

require 'rails_helper'

RSpec.describe ObservationsSubject, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:observation) }
    it { is_expected.to belong_to(:subject) }
  end

  describe 'validations' do
    # Add any specific validation tests if there are additional validations in your model
  end
end