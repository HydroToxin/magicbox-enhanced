# frozen_string_literal: true

# spec/models/condition_group_spec.rb

require 'rails_helper'

RSpec.describe ConditionGroup, type: :model do
  describe 'associations' do
    it { is_expected.to accept_nested_attributes_for(:conditions).allow_destroy(true) }
  end

  describe 'nested attributes for conditions' do
    let(:condition_group) { create(:condition_group) }
    let(:condition) { FactoryBot.build(:condition) }
    let(:data_type) { create(:data_type) }

    context 'when all attributes are blank' do
      it 'does not add a new condition' do
        expect {
          condition_group.update(conditions_attributes: [{ id: '', name: '' }])
        }.not_to change(condition_group.conditions, :count)
      end
    end

    context 'when attributes are present' do
      it 'adds a new condition' do
        expect {
          condition_group.update(conditions_attributes: condition.attributes.merge(data_type_id: data_type.id))
        }.to change(condition_group.conditions, :count).by(1)
      end
    end
  end
end
