# frozen_string_literal: true

# spec/models/application_record_spec.rb

require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do
  describe 'inheritance' do
    it 'inherits from ActiveRecord::Base' do
      expect(ApplicationRecord.superclass).to eq(ActiveRecord::Base)
    end
  end

  describe 'primary abstract class' do
    it 'is a primary abstract class' do
      expect(ApplicationRecord.abstract_class).to be(true)
    end
  end
end