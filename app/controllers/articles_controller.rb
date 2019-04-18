class ArticlesController < ApplicationController

def new
  @article = Article.new
end

def create
  #render json: params[:article] 
  
  @article = Article.new(article_params)
  if @article.save   
    flash[:notice] = "Article Successfully created."
    redirect_to article_path(@article) 
  else
    flash[:alert] = "Failed to create."
    render 'new'
  end
end


def show
   @article = Article.find(params[:id])
end


private
  def article_params
    params.require(:article).permit(:title, :description)
    end

end

