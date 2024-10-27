# frozen_string_literal: true

# Batch model
class Batch < ApplicationRecord
  include ApplicationHelper

  belongs_to :grow
  belongs_to :harvest

  enum batch_type: { trim: 0, bud:	1 }

  # validate :remaining_harvest_weight
  # validate :weight_count_multiplier

  def total_price
    total_weight * price_per_weight
  end

  private

  def weight_count_multiplier
    return unless batch_weight * batch_count > total_weight

    errors.add :batch_weight, 'Batch weight exceeds total weight'
  end

  # rubocop:disable Metrics/MethodLength
  def remaining_harvest_weight
    if trim?
      remaining_harvest_weight = harvest.remaining_weight_for_batch_type(:trim)
      remaining_harvest_weight += total_weight_was if total_weight_was
      if r < total_weight
        errors.add :total_weight,
                   "Not enought trim (#{weight_with_unit remaining_harvest_weight}) " \
                   "in harvest to batch #{weight_with_unit total_weight}"
      end
    elsif bud?
      remaining_harvest_weight = harvest.remaining_weight_for_batch_type(:bud)
      remaining_harvest_weight += total_weight_was if total_weight_was
      if r < total_weight
        errors.add :total_weight,
                   "Not enought bud (#{weight_with_unit remaining_harvest_weight}) " \
                   "in harvest to batch #{weight_with_unit total_weight}"
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
