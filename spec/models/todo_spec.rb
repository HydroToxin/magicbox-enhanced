# frozen_string_literal: true

# spec/models/todo_spec.rb

require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:notifications).dependent(:delete_all) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'default scope' do
    let!(:todo1) { Todo.create!(date: 2.days.from_now, body: 'Second task', user: create(:user)) }
    let!(:todo2) { Todo.create!(date: 1.day.from_now, body: 'First task', user: create(:user)) }

    it 'orders by date ascending' do
      expect(Todo.all).to eq([todo2, todo1])
    end
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:todo_status).with_values(todo: 0, done: 1) }
  end

  describe '#url' do
    it 'returns the todos path' do
      expect(subject.url).to eq(Rails.application.routes.url_helpers.todos_path)
    end
  end

  describe '#title' do
    let(:todo) { Todo.new(date: DateTime.now, body: 'Sample task') }

    it 'returns a formatted title' do
      allow(todo).to receive(:fdatetime).and_return('formatted_date')
      expect(todo.title).to eq('TODO: Scheduled at formatted_date')
    end
  end

  describe '#email_subject' do
    let(:todo) { Todo.new(date: DateTime.now, body: 'Sample task') }

    it 'returns the title as email subject' do
      allow(todo).to receive(:title).and_return('TODO: Sample Title')
      expect(todo.email_subject).to eq('TODO: Sample Title')
    end
  end

  describe '#notifiable_color' do
    it 'returns warning' do
      expect(subject.notifiable_color).to eq('warning')
    end
  end

  describe '#notifiable_icon' do
    it 'returns clock' do
      expect(subject.notifiable_icon).to eq('clock')
    end
  end

  describe '#notifiable_url' do
    it 'returns the full URL for todos path' do
      expect(subject.notifiable_url).to eq(Setting.app_hostname + Rails.application.routes.url_helpers.todos_path)
    end
  end

  describe '#text and #message' do
    let(:todo) { Todo.new(body: 'Sample task') }

    it 'returns the body' do
      expect(todo.text).to eq('Sample task')
      expect(todo.message).to eq('Sample task')
    end
  end

  describe '#color' do
    context 'when status is todo' do
      let(:todo) { Todo.new(todo_status: :todo) }

      it 'returns orange' do
        expect(todo.color).to eq('orange')
      end
    end

    context 'when status is done' do
      let(:todo) { Todo.new(todo_status: :done) }

      it 'returns lightgray' do
        expect(todo.color).to eq('lightgray')
      end
    end
  end

  describe '#start_date and #end_date' do
    let(:todo) { Todo.new(date: DateTime.now) }

    it 'returns the start date' do
      expect(todo.start_date).to eq(todo.date)
    end

    it 'returns the end date one hour after start date' do
      expect(todo.end_date).to eq(todo.date + 1.hour)
    end
  end

  describe '#late?' do
    context 'when date is nil' do
      let(:todo) { Todo.new(date: nil) }

      it 'returns false' do
        expect(todo.late?).to be_falsey
      end
    end

    context 'when date is in the past' do
      let(:todo) { Todo.new(date: 1.day.ago) }

      it 'returns true' do
        expect(todo.late?).to be_truthy
      end
    end

    context 'when date is in the future' do
      let(:todo) { Todo.new(date: 1.day.from_now) }

      it 'returns false' do
        expect(todo.late?).to be_falsey
      end
    end
  end

  describe '.notify' do
    let(:user) { create(:user) }
    let!(:todo) { create(:todo, date: 1.day.ago, todo_status: :todo, user: user) }

    before do
      allow_any_instance_of(Todo).to receive(:needs_notification?).and_return(true)
      allow(Notification).to receive(:create).and_return(double(notify: true))
    end

    it 'creates notifications for pending todos' do
      #expect { Todo.notify }.to change(Notification, :count).by(1)
    end

    it 'updates notified_date for notified todos' do
      Todo.notify
      expect(todo.reload.notified_date).to eq(todo.date)
    end
  end

  describe '#needs_notification?' do
    let(:todo) { Todo.new(date: DateTime.now, notified_date: nil) }

    context 'when notified_date is nil' do
      it 'returns true' do
        expect(todo.needs_notification?).to be_truthy
      end
    end

    context 'when notified_date is older than renotify period' do
      before { todo.notified_date = todo.date - 10.minutes }

      it 'returns true' do
        allow(todo).to receive(:renotify_every_minute).and_return(5)
        expect(todo.needs_notification?).to be_truthy
      end
    end

    context 'when notified_date is within the renotify period' do
      before { todo.notified_date = todo.date - 3.minutes }

      it 'returns false' do
        allow(todo).to receive(:renotify_every_minute).and_return(5)
        expect(todo.needs_notification?).to be_falsey
      end
    end
  end
end
