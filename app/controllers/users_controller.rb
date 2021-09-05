# Controlador para administración de usuaries.
class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    authorize User

    # Autorización.
    @users = policy_scope(User).order(created_at: :desc)

    # Paginación.
    @pagy, @users = pagy(@users)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @user.assign_attributes user_params

    respond_to do |format|
      if @user.save
        # TODO, Resaltar a le usuarie recién creade en el index, o redirigir al show.
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
    raise Pundit::NotAuthorizedError, t('sin_autorizacion') unless roles_validos?

    roles_params.each do |rol, asignado|
      ActiveModel::Type::Boolean.new.cast(asignado) ? @user.roles << rol : @user.roles.delete(rol)
    end

    respond_to do |format|
      if @user.save
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
    @user =
      if params[:id].present?
        authorize User.find(params[:id])
      else
        authorize User.new
      end
  end

  # Parámetros para creación de usuaries por admins.
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
  def roles_validos?
    !(roles_params.include?(:administracion) && @user == current_user)
  end
end
