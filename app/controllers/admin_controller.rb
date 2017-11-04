class AdminController < ApplicationController

  def index
    @articles = current_user.articles.all.order(:published_at)
  end

  def my_articles
    @articles = current_user.articles.all.order(:published_at)
  end

  def follow_user
    respond_to do |format|
      if !current_user.follows(params[:user_id]).any? && Following.create!(user_id: current_user.id, follow_type: 'User', follow_id: params[:user_id])
        format.js
      else
        current_user.follows(params[:user_id]).first.destroy!
        format.js
      end
    end
  end

end
