# frozen_string_literal: true

FactoryBot.define do
  factory(:user) do
    username              { 'admin' }
    email                 { Faker::Internet.email }
    password              { 'changeme' }
    password_confirmation { 'changeme' }
    admin                 { false }
  end
end