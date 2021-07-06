# frozen_string_literal: true

FactoryBot.define do
  factory :r_package do
    name { FFaker::Product.product_name }
    version { '0.0.1' }
    published_at { Time.current }
    title { FFaker::Lorem.sentence }
    description { FFaker::Lorem.paragraph }
    authors { [{ name: FFaker::Name.name, email: FFaker::Internet.email }] }
    maintainers { [{ name: FFaker::Name.name, email: FFaker::Internet.email }] }
  end
end
