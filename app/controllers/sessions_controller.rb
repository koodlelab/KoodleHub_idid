class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:user_session][:email])
    if @user && @user.authenticate(params[:user_session][:password])
      login @user
      params[:user_session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    logout if login?
    redirect_to root_url
  end
end
