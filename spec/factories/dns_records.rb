# frozen_string_literal: true

FactoryBot.define do
  factory :dns_record do
    ip_address { Faker::Internet.public_ip_v4_address }

    # We are considering IPV6 invalid for testing purposes
    trait :with_invalid_ip do
      ip_address { Faker::Internet.ip_v6_address }
    end

    trait :with_related_hostnames do
      hostnames { create_list(:related_hostname, 5) }
    end
  end
end
