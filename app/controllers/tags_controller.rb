class TagsController < ApplicationController

  def show
    @tag = Tag.find_by('lower(name) = ?', params[:id])
    @articles = @tag.articles.order(published_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

end
