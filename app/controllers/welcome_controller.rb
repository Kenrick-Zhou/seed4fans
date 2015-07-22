class WelcomeController < ApplicationController
  def index
    @duser_size = Duser.all().size()
    @duser_last = Duser.last

    @movie_size = Movie.all().size()
    @movie_last = Movie.last
  end
end