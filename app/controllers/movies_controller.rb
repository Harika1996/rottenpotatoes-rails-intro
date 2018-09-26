class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.rate.uniq
    if session[:sort] ==nil or (params[:sort]!=session[:sort] and params[:sort]!=nil)
      if params[:sort] ==nil
        session[:sort] = ""
      else
        session[:sort] = params[:sort]
      end
    end
    if session[:ratings] == nil or params[:commit]!=nil
      if params[:ratings] != nil
        session[:ratings] = params[:ratings]
      else
        session[:ratings] = []
      end
    end
    @rate_checking = session[:ratings]
    if session[:ratings].blank?
      if session[:sort] == ""
        @movies = Movie.all
      else
        @movies = Movie.order(session[:sort])
      end
    else 
      if session[:sort]==""
        @movies = Movie.all.select {|i| session[:ratings].include?(i.rating)?true:false}
      else
        @movies = Movie.order("#{session[:sort]}").select {|i| session[:ratings].include?(i.rating)?true:false}
      end
    end
   
   @class_var = ""
   @class_var2 = ""
    if session[:sort] == "title"
     @class_var = "hilite"
     @class_var2 = ""
    elsif session[:sort] == "release_date"
      @class_var = ""
      @class_var2 ="hilite"
    end
  end
  
  

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
