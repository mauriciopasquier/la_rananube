FactoryBot.define do
  factory :user do
    email
    nombre { generate :string_unico }
    password { '123456' }
    password_confirmation { password }

    # Necesitan estar confirmadxs para poder loguearse.
    trait :confirmade do
      confirmed_at { Date.yesterday }
    end
  end
end
