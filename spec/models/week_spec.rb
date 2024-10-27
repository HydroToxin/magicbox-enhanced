# frozen_string_literal: true

# spec/models/week_spec.rb

require 'rails_helper'

RSpec.describe Week, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:grow) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:week_number) }
    it { is_expected.to validate_presence_of(:week_type) }
  end

  describe 'scopes' do
    it 'orders by start_date descending by default' do
      week1 = create(:week, start_date: Date.today)
      week2 = create(:week, start_date: Date.yesterday)

      expect(Week.all).to eq([week1, week2])
    end
  end

  describe '#text' do
    let(:grow) { create(:grow, description: 'Tomato Plant') }
    let(:week) { create(:week, grow: grow, week_number: 3, week_type: :vegging) }

    it 'returns a formatted text string' do
      expect(week.text).to eq('Tomato Plant - Week #3 (vegging)')
    end
  end

  describe '#url' do
    let(:grow) { create(:grow) }
    let(:week) { create(:week, grow: grow) }

    it 'returns the URL for the associated grow' do
      expect(week.url).to eq(Rails.application.routes.url_helpers.grow_path(grow))
    end
  end

  describe '#color' do
    let(:week) { create(:week, week_type: :flowering) }

    it 'returns the HTML color for the week type' do
      expect(week.color).to eq('#CE93D8')
    end
  end

  describe '#start_time' do
    let(:week) { create(:week, start_date: Date.today) }

    it 'returns the start date' do
      expect(week.start_time).to eq(Date.today)
    end
  end

  describe '#end_time' do
    let(:week) { create(:week, end_date: Date.tomorrow) }

    it 'returns the end date' do
      expect(week.end_time).to eq(Date.tomorrow)
    end
  end

  describe '#progress_border_color' do
    let(:week) { create(:week, start_date: Date.yesterday, end_date: Date.tomorrow) }

    context 'when current date is before start date' do
      it 'returns border-secondary' do
        allow(Date).to receive(:today).and_return(Date.yesterday - 1)
        expect(week.progress_border_color).to eq('border-secondary')
      end
    end

    context 'when current date is after end date' do
      it 'returns border-light' do
        allow(Date).to receive(:today).and_return(Date.tomorrow + 1)
        expect(week.progress_border_color).to eq('border-light')
      end
    end

    context 'when current date is within the range' do
      it 'returns border-primary' do
        allow(Date).to receive(:today).and_return(Date.today)
        expect(week.progress_border_color).to eq('border-primary')
      end
    end
  end

  describe '#current?' do
    let(:week) { create(:week, start_date: Date.yesterday, end_date: Date.tomorrow) }

    context 'when current date is within the range' do
      it 'returns true' do
        allow(Date).to receive(:today).and_return(Date.today)
        expect(week.current?).to be true
      end
    end

    context 'when current date is outside the range' do
      it 'returns false' do
        allow(Date).to receive(:today).and_return(Date.tomorrow + 1)
        expect(week.current?).to be false
      end
    end
  end

  describe '#html_color' do
    it 'returns the correct HTML color for each week type' do
      expect(create(:week, week_type: :seedling).html_color).to eq('lightgreen')
      expect(create(:week, week_type: :vegging).html_color).to eq('#2ECC71')
      expect(create(:week, week_type: :flowering).html_color).to eq('#CE93D8')
      expect(create(:week, week_type: :flushing).html_color).to eq('blue')
      expect(create(:week, week_type: :drying).html_color).to eq('maroon')
      expect(create(:week, week_type: :curing).html_color).to eq('lightgray')
    end
  end
end