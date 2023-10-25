class MoviesController < ApplicationController
  def index 
      @user = User.find(params[:id])
      @movies = Movie.all
  end 

  def show 
    if params[:user_id].present?
      @user = User.find(params[:user_id])
    end
      @movie = Movie.find(params[:id])
  end 
end 
