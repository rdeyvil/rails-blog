class UsersController < ApplicationController

  before_action :logged_in?, only:[:edit, :update]
  before_action :require_admin, only:[:destroy]

  def index
    @user =  User.paginate(page: params[:page], per_page: 5)
    
  end

  def new 
    @user = User.new  
  end

  def create
    @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "User Successfully created \n Welcome #{@user.username}"
        redirect_to user_path(@user)
      else
        render 'new'
      end
  end
  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
      if @user.check_authorization(current_user)
        if @user.update(user_params)
          flash[:notice] = "Your account is sucessfully updated"
          redirect_to articles_path
      end 
      else
          flash[:alert] = "You are not authorized for this action"
          redirect_to users_path
    end
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    @user = User.find(params[:id])
      if @user.check_authorization(current_user)  
        @user.destroy
        flash[:notice] = "User and all articles created by user have been deleted!"
        redirect_to users_path
      end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  
end