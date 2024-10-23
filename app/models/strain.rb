# frozen_string_literal: true

# Strain
class Strain < ApplicationRecord
  enum strain_type: { indica: 0, sativa: 1, hybrid: 2, ruderalis: 3, unknow: 10 }

  # rubocop:disable Metrics/CyclomaticComplexity
  def self.search(params)
    strains = Strain.all

    strains.where!('name iLIKE ?', "%#{params[:search]}%") if params[:search].present?
    strains.where!(strain_type: params[:strain_type]) if params[:strain_type].present?
    strains.where!('location iLIKE ?', "%#{params[:location]}%") if params[:location].present?
    strains.where!(breeder: params[:breeder]) if params[:breeder].present?
    strains.where!('effects @> ARRAY[?]', [params[:effect]]) if params[:effect].present?
    strains.where!('ailments @> ARRAY[?]', [params[:ailment]]) if params[:ailment].present?
    strains.where!('flavors @> ARRAY[?]', [params[:flavor]]) if params[:flavor].present?

    strains
  end
  # rubocop:enable Metrics/CyclomaticComplexity
end
