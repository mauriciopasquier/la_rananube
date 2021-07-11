FactoryBot.define do
  factory :user do
    email
    password { '123456' }
    nombre { generate :string_unico }

    # Necesitan estar confirmadxs para poder loguearse.
    trait :confirmade do
      confirmed_at { Date.yesterday }
    end
  end
end
