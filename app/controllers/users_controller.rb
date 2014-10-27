class UsersController < ApplicationController
  before_action :logged_in, only: [:edit, :update, :index, :destroy]
  before_action :validate_user, only: [:edit, :update]
  before_action :validate_admin, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #
      # login @user
      # flash[:success] = "Welcome to Koodo Hub!"
      # redirect_to @user
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def logged_in
      unless login?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def validate_user
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to root_url
      end
    end

    def validate_admin
      unless current_user.admin
        flash[:danger] = "Unauthorized delete."
        redirect_to root_url
      end
    end
end
