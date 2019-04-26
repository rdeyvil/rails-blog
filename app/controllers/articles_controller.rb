class ArticlesController < ApplicationController

def index 
  @article = Article.all
  render 'index'
end 

def new
  @article = Article.new
end

def create
  # render plain: params[:article] 
     
  #  binding.pry
     
  @article = Article.new(article_params)

  #  binding.pry
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

def edit
  @article = Article.find(params[:id])
end

def update
  @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was sucessfully updated"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Failed to update"
      render 'edit'
    end
end

private
  def article_params
    params.require(:article).permit(:title, :description)
    end

end

