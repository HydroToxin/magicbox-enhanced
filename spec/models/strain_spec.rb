# frozen_string_literal: true

# spec/models/strain_spec.rb

require 'rails_helper'

RSpec.describe Strain, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      strain = Strain.new(name: 'Blue Dream')
      expect(strain).to be_valid
    end

    it 'is invalid without a name' do
      strain = Strain.new(name: nil)
      expect(strain).not_to be_valid
    end
  end

  describe '.search' do
    let!(:indica_strain) { Strain.create!(name: 'Indica Strain', strain_type: :indica, location: 'California', breeder: 'Breeder A', effects: ['Relaxing'], ailments: ['Pain'], flavors: ['Earthy']) }
    let!(:sativa_strain) { Strain.create!(name: 'Sativa Strain', strain_type: :sativa, location: 'Oregon', breeder: 'Breeder B', effects: ['Energizing'], ailments: ['Fatigue'], flavors: ['Citrus']) }

    it 'returns strains matching the search term' do
      result = Strain.search(search: 'Indica')
      expect(result).to include(indica_strain)
      expect(result).not_to include(sativa_strain)
    end

    it 'filters by strain_type' do
      result = Strain.search(strain_type: 'sativa')
      expect(result).to include(sativa_strain)
      expect(result).not_to include(indica_strain)
    end

    it 'filters by location' do
      result = Strain.search(location: 'California')
      expect(result).to include(indica_strain)
      expect(result).not_to include(sativa_strain)
    end

    it 'filters by breeder' do
      result = Strain.search(breeder: 'Breeder A')
      expect(result).to include(indica_strain)
      expect(result).not_to include(sativa_strain)
    end

    it 'filters by effect' do
      result = Strain.search(effect: 'Relaxing')
      expect(result).to include(indica_strain)
      expect(result).not_to include(sativa_strain)
    end

    it 'filters by ailment' do
      result = Strain.search(ailment: 'Pain')
      expect(result).to include(indica_strain)
      expect(result).not_to include(sativa_strain)
    end

    it 'filters by flavor' do
      result = Strain.search(flavor: 'Earthy')
      expect(result).to include(indica_strain)
      expect(result).not_to include(sativa_strain)
    end
  end
end