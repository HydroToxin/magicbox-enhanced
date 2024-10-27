# frozen_string_literal: true

# spec/models/devices_data_type_spec.rb

require 'rails_helper'

RSpec.describe DevicesDataType, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:device).class_name('Device') }
    it { is_expected.to belong_to(:data_type).class_name('DataType') }
  end
end