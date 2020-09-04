class Admins::UsersController < Admins::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  def index
    @users = User.all
  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)
    if @user.save
      if user_params[:avatar]
        @user.avatar = user_params[:avatar]
        @user.save!
      end
      redirect_to admins_users_path, notice: t('flash.users.create')
    else
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @user.update(user_params)
      if user_params[:avatar]
        @user.avatar = user_params[:avatar]
        @user.save!
      end
      redirect_to admins_users_path, notice: t('flash.users.update')
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @user.destroy
    redirect_to admins_users_path, notice: t('flash.users.destroy')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :username, :register_number, :cpf, :status, :avatar)
    end
end
