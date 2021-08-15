# Controlador para administración de usuarixs.
class UsersController < ApplicationController
  before_action :set_user, only: [
    :show, :edit, :update, :destroy, :roles
  ]
  before_action :validar_roles, only: :roles

  def index
    # TODO, Agregar paginación.
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: t('.notice') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: t('.notice') }
      else
        format.html { render :edit }
      end
    end
  end

  def roles
    roles_params.each do |rol, asignado|
      ActiveModel::Type::Boolean.new.cast(asignado) ? @user.roles << rol : @user.roles.delete(rol)
    end

    respond_to do |format|
      if @roles_validos && @user.save
        format.json { render json: { notice: t('.notice') }, status: :ok }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url, notice: t('.notice') }
      else
        format.html { redirect_to users_path }
      end
    end
  end

  private

  # Cargar le usuarie desde los params.
  def set_user
    @user = User.find(params[:id])
  end

  # Parámetros para creación de usuarixs por admins.
  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :nombre, roles: []
    )
  end

  # Permitimos los roles definidos en User y nada más.
  def roles_params
    params.require(:roles).permit(User.roles.values)
  end

  # Impedir modificarse a unx mismx el rol de administración.
  def validar_roles
    @roles_validos = !(roles_params.include?(:administracion) && @user == current_user)
  end
end
