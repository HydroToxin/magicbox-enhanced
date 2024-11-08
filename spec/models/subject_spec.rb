# frozen_string_literal: true

# spec/models/subject_spec.rb

require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:grow) }
    it { is_expected.to belong_to(:room).optional }
    it { is_expected.to belong_to(:strain).optional }
    # it { is_expected.to belong_to(:mother).optional.class_name('Subject').dependent(:destroy) }
    # it { is_expected.to have_many(:clones).class_name('Subject') }
    # it { is_expected.to have_many(:observations).through(:observation_subjects) }
    # it { is_expected.to have_many(:observation_resources).through(:observations) }
    # it { is_expected.to have_many(:issues).through(:observations) }
    it { is_expected.to have_many(:scenarios).dependent(:destroy) }
    # it { is_expected.to have_many(:events).as(:eventable).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  # describe '#name_with_grow' do
  #   let(:grow) { Grow.create(description: 'Test Grow') }
  #   let(:subject) { Subject.create!(name: 'Test Subject', grow: grow) }

  #   it 'returns the full name with grow ID' do
  #     expect(subject.name_with_grow).to eq("##{subject.id} - Test Subject [Grow##{grow.id}]")
  #   end
  # end

  # describe '#generate_qr' do
  #   let(:grow) { Grow.create!(name: 'Test Grow') }
  #   let(:subject) { Subject.create!(name: 'Test Subject', grow: grow) }

  #   it 'generates a QR code as a base64 string' do
  #     qr_code = subject.generate_qr(5)
  #     expect(qr_code).to start_with('data:image/png;base64,')
  #   end
  # end

  # describe '#generate_barecode' do
  #   let(:subject) { Subject.create!(name: 'Test Subject', grow: Grow.create!(name: 'Test Grow')) }

  #   it 'generates a barcode as a base64 string' do
  #     barcode = subject.generate_barecode
  #     expect(barcode).to start_with('data:image/png;base64,')
  #   end
  # end

  # describe '#fullname' do
  #   let(:subject) { Subject.create!(name: 'Test Subject', grow: Grow.create!(name: 'Test Grow')) }

  #   it 'returns the full name with ID' do
  #     expect(subject.fullname).to eq("##{subject.id} - Test Subject")
  #   end
  # end

  # describe '#strain_name' do
  #   context 'when strain is present' do
  #     let(:strain) { Strain.create!(name: 'Test Strain') }
  #     let(:subject) { Subject.create!(name: 'Test Subject', grow: Grow.create!(name: 'Test Grow'), strain: strain) }

  #     it 'returns the strain name' do
  #       expect(subject.strain_name).to eq('Test Strain')
  #     end
  #   end

  #   context 'when strain is not present' do
  #     let(:subject) { Subject.create!(name: 'Test Subject', grow: Grow.create!(name: 'Test Grow')) }

  #     it 'returns an empty string' do
  #       expect(subject.strain_name).to eq('')
  #     end
  #   end
  # end
end
