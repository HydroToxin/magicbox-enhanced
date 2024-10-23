# frozen_string_literal: true

# ApplicationJob
class ApplicationJob
  include Sidekiq::Worker
end
