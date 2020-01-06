FactoryBot.define do
  factory :ip_entry do
    address { Faker::Internet.public_ip_v4_address }
  end
end
