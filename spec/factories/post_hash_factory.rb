FactoryBot.define do
  factory :post_hash, class: Hash do
    defaults = {
      dns_records: {
        ip: Faker::Internet.public_ip_v4_address.to_s,
        hostnames_attributes: [
          { hostname: Faker::Internet.domain_name(subdomain: true) },
          { hostname: Faker::Internet.domain_name(subdomain: true) },
          { hostname: Faker::Internet.domain_name(subdomain: true) }
        ]
      }
    }
    initialize_with { defaults.merge(attributes) }
  end
end
