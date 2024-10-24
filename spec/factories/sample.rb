# frozen_string_literal: true

FactoryBot.define do
  factory :sample do
    product_reference { "Product Ref" }
    unit { "Unit" }
    html_color { "#FFFFFF" }
    category_name { "Category Name" }
    value { "Sample Value" }
    association :data_type
    association :device
  end
end