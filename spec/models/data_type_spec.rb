# frozen_string_literal: true

# spec/models/data_type_spec.rb
require 'rails_helper'

RSpec.describe DataType, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:samples) }
    it { is_expected.to have_many(:devices_data_types) }
    it { is_expected.to have_many(:devices).through(:devices_data_types) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end