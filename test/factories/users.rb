FactoryBot.define do
  factory :user do
    email
    password { '123456' }
    nombre { generate :string_unico }
  end
end
