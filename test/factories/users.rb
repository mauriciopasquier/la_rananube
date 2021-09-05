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

    # Cargados post inicialización porque pueden ser múltiples roles.
    trait :administracion do
      after(:build, :stub) { |user| user.roles << :administracion }
    end

    trait :clientes do
      after(:build, :stub) { |user| user.roles << :clientes }
    end
  end
end
