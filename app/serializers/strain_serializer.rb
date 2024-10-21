# frozen_string_literal: true

# StrainSerializer
class StrainSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :strain_type, :crosses, :breeder, :effects, :ailments, :flavors, :location,
             :terpenes
end
