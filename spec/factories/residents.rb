FactoryBot.define do
  factory :resident do
    full_name { Faker::Name.name }
    document { Faker::CPF.numeric }
    health_card_document { %w[249084314970001 137879980450000 726682432710005 850388644060001 966040124940005].sample }
    email { Faker::Internet.email }
    birthdate { Faker::Date.birthday(min_age: 0, max_age: 125) }
    phone { %w[5562993178387 5511940594050].sample }
    status { %w[active inactive].sample }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/image.png'), 'image/png') }

    trait :with_invalid_email do
      email { 'lauretta.mohr@.ru' }
    end

    trait :with_invalid_document do
      document { [Faker::Number.number(digits: (0..10).to_a.sample),
                  Faker::Number.number(digits: (11..255).to_a.sample),
                  Faker::Number.number(digits: 11)].sample }
    end

    trait :with_birthdate_backward_than_125_years do
      birthdate { Faker::Date.backward(days: 125.years.days + 1) }
    end

    trait :with_birthdate_forward_than_today do
      birthdate { Faker::Date.forward(days: 10.years.days) }
    end

    trait :with_health_card_length_different_than_fifteen do
      health_card_document { [Faker::Number.number(digits: (1..14).to_a.sample),
                              Faker::Number.number(digits: (16..255).to_a.sample)].sample }
    end

    trait :with_repeated_digits_for_health_card do
      health_card_document { (0..9).to_a.sample.to_s * 15 }
    end
  end
end
