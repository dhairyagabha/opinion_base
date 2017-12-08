module Api
  module V1
    class AuthorsController < ActionController::Base
      def index
        authors = User.all
        render json: authors
      end

      def show
        author = User.find(params[:id])
        if author.present?
          render json: {author: author, articles: author.articles}
        end
      end
    end
  end
end