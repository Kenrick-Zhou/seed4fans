class MovieCountriesController < ApplicationController
  before_action :set_movie_country, only: [:show, :edit, :update, :destroy]

  # GET /movie_countries
  # GET /movie_countries.json
  def index
    @movie_countries = MovieCountry.all
  end

  # GET /movie_countries/1
  # GET /movie_countries/1.json
  def show
  end

  # GET /movie_countries/new
  def new
    @movie_country = MovieCountry.new
  end

  # GET /movie_countries/1/edit
  def edit
  end

  # POST /movie_countries
  # POST /movie_countries.json
  def create
    @movie_country = MovieCountry.new(movie_country_params)

    respond_to do |format|
      if @movie_country.save
        format.html { redirect_to @movie_country, notice: 'Movie country was successfully created.' }
        format.json { render :show, status: :created, location: @movie_country }
      else
        format.html { render :new }
        format.json { render json: @movie_country.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_countries/1
  # PATCH/PUT /movie_countries/1.json
  def update
    respond_to do |format|
      if @movie_country.update(movie_country_params)
        format.html { redirect_to @movie_country, notice: 'Movie country was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie_country }
      else
        format.html { render :edit }
        format.json { render json: @movie_country.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_countries/1
  # DELETE /movie_countries/1.json
  def destroy
    @movie_country.destroy
    respond_to do |format|
      format.html { redirect_to movie_countries_url, notice: 'Movie country was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_country
      @movie_country = MovieCountry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_country_params
      params.require(:movie_country).permit(:movie_id, :country_id, :name)
    end
end
