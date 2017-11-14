class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @articles = Article.all.order(published_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)
    @article.permalink = @article.name.downcase.gsub(' ', '-').gsub!(/[^-0-9A-Za-z_.]/, '')
    @article.tag_list = params["article"]["tag_list"].reject { |c| c.empty? }.join(',')
    if params[:commit] == 'Publish Article'
      @article.published_at = Time.now
    end
    respond_to do |format|
      if @article.save
        format.html { redirect_to article_path(@article), notice: 'Article was successfully created!' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    @article.tag_list = params["article"]["tag_list"].reject { |c| c.empty? }.join(',')
    if @article.update!(article_params)
      redirect_to article_path(@article), notice: 'Article updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @article = current_user.articles.find(params[:id])
    if @article.destroy!
      redirect_to :index, notice: 'Article deleted successfully!'
    else
      redirect_back(fallback_location: @article, alert: 'Cannot delete article!')
    end
  end

  def search
    @articles = Article.search(params[:query]).order(published_at: :desc).paginate(:page => params[:page], :per_page => 10)
    render :index
  end

  def interaction
    article = Article.find(params[:id])
    if !article.interactions.where(interaction: params[:interaction], user: current_user).any?
      @interaction = article.interactions.new(interaction: params[:interaction], user: current_user)
      respond_to do |format|
        if @interaction.save
          format.js
        end
      end
    else
      article.interactions.where(interaction: params[:interaction], user: current_user).first.destroy
      @interaction = params[:interaction] == 'Like' ? 'Dislike' : 'Delete Bookmark'
      @article = article
    end
  end

  def author
    @user = User.find_by(username: params[:username])
    @articles = @user.articles.order(published_at: :desc).paginate(:page => params[:page], :per_page => 10)
    render :index
  end

  private
  def article_params
    params.require(:article).permit(:name, :excerpt, :body, :permalink, :published_at, :anonymous, :user_id)
  end

end
