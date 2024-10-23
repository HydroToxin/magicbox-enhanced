# frozen_string_literal: true

# ObservationsSubject
class ObservationsSubject < ApplicationRecord
  belongs_to :observation
  belongs_to :subject
end
