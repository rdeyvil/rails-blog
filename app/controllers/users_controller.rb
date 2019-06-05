class UsersController < ApplicationController
  def new 
    @user = User.new  
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User Successfully created \n Welcome #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Your account is sucessfully updated"
      redirect_to articles_path
    else
    
    end 
  end
  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
end