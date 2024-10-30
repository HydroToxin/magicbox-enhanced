# frozen_string_literal: true

class Observations::ObservationResourceComponent < ViewComponent::Base
  def initialize(title:, content:)
    @title = title
    @content = content
  end
end
