class ArticlesController < ApplicationController
  before_action :logged_in?, except: [:index, :show]
  
  before_action :set_article, only: [:show, :edit, :update, :destroy] 
  
  before_action :require_user, except: [:index, :show]

  def index 
    @article = Article.paginate(page: params[:page], per_page: 5)
    
  end 

  def new
    @article = Article.new
  end

  def create
    
    # render plain: params[:article] 
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save   
      flash[:notice] = "Article Successfully created."
      redirect_to article_path(@article) 
    else
      flash[:alert] = "Failed to create."
      render 'new'
    end
  end


  def show

  end

  def edit
    if @article.check_user_authorization(current_user)
      render 'edit'
    else
      flash[:alert] = "You are not authorized"
      redirect_to  root_path 
    end
  end

  def update
    if @article.check_user_authorization(current_user)
      if @article.update(article_params)
        flash[:notice] = "Article was sucessfully updated"
        redirect_to article_path(@article)
      else
        flash[:alert] = "Failed to update"
        render 'edit'
      end
    else
      flash[:alert] = "You are not authorized to edit this article"
      redirect_to root_path
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article was sucessfully deleted"
    redirect_to articles_path
  end


  private
    def set_article
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :description)
    end

end

