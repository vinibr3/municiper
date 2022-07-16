FactoryBot.define do
  factory :address do
    zipcode { Faker::Address.zip_code.gsub(/\D/, '').first(8) }
    street { Faker::Address.street_name }
    complement { Faker::Address.secondary_address }
    neighboorhood { Faker::Address.community }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr.first(2) }
    ibge_code { Faker::Code.sin }
    addressable { association(:resident) }
  end
end
