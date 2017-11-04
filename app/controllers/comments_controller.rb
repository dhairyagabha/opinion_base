class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @entity = params[:class].constantize.find(params[:entity])
    respond_to do |format|
      format.js
    end
  end

  def create
    @comment = current_user.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.js
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :entity_id, :entity_type, :user_id)
  end

end
