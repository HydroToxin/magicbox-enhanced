# frozen_string_literal: true

# Observation
class Observation < ApplicationRecord
  belongs_to :user
  belongs_to :grow
  belongs_to :room, optional: true

  has_many :events, as: :eventable, dependent: :destroy
  has_many :observations_subjects, dependent: :destroy
  has_many :observation_resources, class_name: 'ObservationResource'
  has_many :subjects, through: :observations_subjects, dependent: :destroy
  has_many :issues

  accepts_nested_attributes_for :observation_resources, allow_destroy: true, reject_if: proc { |attributes|
    attributes['value'].blank?
  }
  accepts_nested_attributes_for :issues

  has_many_attached :pictures

  validates :body, presence: true
  validates :subject_ids, presence: true

  def start_date
    created_at
  end

  def end_date
    created_at + 1.hour if created_at.present?
  end

  def text
    body
  end

  def pictures_url
    pictures.map do |e|
      Rails.application.routes.url_helpers.rails_blob_url(e, host: ActiveStorage::Current.host)
    end
  end

  def url
    Rails.application.routes.url_helpers.grow_observation_path(grow, self)
  end
end
