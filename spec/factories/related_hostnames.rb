# frozen_string_literal: true

FactoryBot.define do
  factory :related_hostname do
    hostname { Faker::Internet.domain_name(subdomain: true) }

    # We are using an entire URL as invalid only for testing purposes
    trait :with_invalid_hostname do
      hostname { Faker::Internet.url }
    end

    trait :with_dns_record do
      dns_records { create_list(:dns_record, 2) }
    end
  end
end
