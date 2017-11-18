class AuthorsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]

  def index
    @authors = User.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @author = User.includes(:articles).find_by(username: params[:id])
  end

  def edit
    @author = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_back(fallback_location:root_url)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :description, :avatar, :facebook, :instagram, :pinterest, :twitter, :time_zone)
  end

end
