class UsersController < ApplicationController
    before_action :set_user, only: [:destroy, :update, :active]

  def index
    @users = User.order(id: :desc)
    authorize @users
  end

  def show
      @users = user.find(params[:id])
  end

  def new
      @user = User.new
  end

  def create
      @user = User.new(user_params)
  end

  def edit
  end

  def update
      if @user.update(user_params)
          redirect_to users_path
      else
          render :edit
      end
  end

  def destroy
      @user.status = "inactive"
      @user.save
      redirect_to users_gerencial_path
  end

  def active
    @user.status = "active"
    @user.save
    redirect_to users_gerencial_path

  end

  def gerencial
    @users = User.order(id: :desc)
    authorize @users
  end

  private

  def set_user
      @user = User.find(params[:id])
      # authorize @user
  end

  def user_params
      params.required(:user).permit(:name , :email, :password, :password_confirmation, :role)

  end
end
