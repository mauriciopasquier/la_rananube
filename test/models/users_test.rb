require 'test_helper'

describe User do
  it 'requiere nombre' do
    _(build(:user, nombre: nil)).wont_be :valid?
    _(build(:user, nombre: '')).wont_be :valid?
  end
end
