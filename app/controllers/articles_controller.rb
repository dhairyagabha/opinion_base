class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find_by(permalink: params[:id])
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)
    @article.permalink = @article.name.downcase.gsub(' ','-').gsub!(/[^-0-9A-Za-z_.]/, '')
    @article.tag_list = params["article"]["tag_list"].reject { |c| c.empty? }.join(',')
    if params[:commit] == 'Publish Article'
      @article.published_at = Time.now
    end
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created!' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @article = current_user.articles.find_by(permalink: params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update!(article_params)
      redirect_to article_path(@article.permalink), notice: 'Article updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @article = current_user.articles.find_by(permalink: params[:id])
    if @article.destroy!
      redirect_to :index, notice: 'Article deleted successfully!'
    else
      redirect_back(fallback_location: @article, alert: 'Cannot delete article!')
    end
  end

  private
  def article_params
    params.require(:article).permit(:name, :excerpt, :body, :permalink, :published_at, :anonymous, :user_id)
  end

end
