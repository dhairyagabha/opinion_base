module Api
  module V1
    class ArticlesController < ActionController::Base
      def index
        articles = Article.includes(:user).order(published_at: :desc).select("articles.*, u.username").joins("left join users u on u.id = articles.user_id").all
        render json: articles
      end

      def show
        article = Article.find(params[:id])
        if article.present?
          render json: {article: article, comments: article.comments, author: article.user}
        end
      end

      private
      def client_params
        params.require(:client).permit!
      end
    end
  end
end