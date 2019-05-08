class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update] 
  def index 
    @article = Article.all
    render 'index'
  end 

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article] 
    @article = Article.new(article_params)
    @article.user = User.first
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

  end

  def update
      if @article.update(article_params)
        flash[:notice] = "Article was sucessfully updated"
        redirect_to article_path(@article)
      else
        flash[:alert] = "Failed to update"
        render 'edit'
      end
  end

  def destroy
    @article.destroy
    flashp[:notice] = "Article was sucessfully deleted"
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

