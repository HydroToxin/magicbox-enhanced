# frozen_string_literal: true

json.array! @strains, partial: 'strains/strain', as: :strain
