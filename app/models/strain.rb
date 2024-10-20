# frozen_string_literal: true

class Strain < ApplicationRecord
  enum strain_type: { indica: 0, sativa: 1, hybrid: 2, ruderalis: 3, unknow: 10 }

  def self.search(params)
    events = Strain.all

    events = events.where('name iLIKE ?', "%#{params[:search]}%") if params[:search].present?

    events = events.where(strain_type: params[:strain_type]) if params[:strain_type].present?

    events = events.where('location iLIKE ?', "%#{params[:location]}%") if params[:location].present?

    events = events.where(breeder: params[:breeder]) if params[:breeder].present?

    events = events.where('effects @> ARRAY[?]', [params[:effect]]) if params[:effect].present?

    events = events.where('ailments @> ARRAY[?]', [params[:ailment]]) if params[:ailment].present?

    events = events.where('flavors @> ARRAY[?]', [params[:flavor]]) if params[:flavor].present?

    events
  end
end
