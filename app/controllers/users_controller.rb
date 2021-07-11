# Controlador para administración de usuarixs.
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
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
        format.html { redirect_to @user, notice: 'FIXME Fuser was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'FIXME Fuser was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to fusers_url, notice: 'Fuser was successfully destroyed.' }
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
    params.require(:user).permit(:email, :password, :password_confirmation, :nombre)
  end
end
