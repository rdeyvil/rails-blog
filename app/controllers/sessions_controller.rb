class SessionsController < ApplicationController

  def new
   
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      flash[:notice] = "You're sucessfully logged in !"
      redirect_to user_path(user)
    else
      flash[:notice] = "Something went wrong!"
      render 'new'
    end

  end

  def destroy
    
    session[:user_id] = nil
    flash[:notice] = "You've logged out"
    redirect_to root_path
  end
 
end
