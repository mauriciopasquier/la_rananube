# Métodos generales y helpers para factories.
FactoryBot.define do
  # Genera un email random.
  sequence(:email) do |n|
    "email-#{n}@ejemplo.com"
  end

  # Genera un string único.
  sequence :string_unico, 'a'

  sequence :numero_unico, 1
end
