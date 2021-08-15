# Reglas de acceso para User.
class UserPolicy < ApplicationPolicy
  def index?
    user.roles.administracion?
  end

  def show?
    user.roles.administracion?
  end

  def create?
    user.roles.administracion?
  end

  def update?
    user.roles.administracion?
  end

  def roles?
    user.roles.administracion?
  end

  def destroy?
    user.roles.administracion?
  end

  # Reglas para las listas de usuaries.
  class Scope < Scope
    def resolve
      if user.roles.administracion?
        scope.all
      else
        scope.none
      end
    end
  end
end
