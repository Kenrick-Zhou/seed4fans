class MovieCelebritiesController < ApplicationController
  before_action :set_movie_celebrity, only: [:show, :edit, :update, :destroy]

  # GET /movie_celebrities
  # GET /movie_celebrities.json
  def index
    @movie_celebrities = MovieCelebrity.all
  end

  # GET /movie_celebrities/1
  # GET /movie_celebrities/1.json
  def show
  end

  # GET /movie_celebrities/new
  def new
    @movie_celebrity = MovieCelebrity.new
  end

  # GET /movie_celebrities/1/edit
  def edit
  end

  # POST /movie_celebrities
  # POST /movie_celebrities.json
  def create
    @movie_celebrity = MovieCelebrity.new(movie_celebrity_params)

    respond_to do |format|
      if @movie_celebrity.save
        format.html { redirect_to @movie_celebrity, notice: 'Movie celebrity was successfully created.' }
        format.json { render :show, status: :created, location: @movie_celebrity }
      else
        format.html { render :new }
        format.json { render json: @movie_celebrity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_celebrities/1
  # PATCH/PUT /movie_celebrities/1.json
  def update
    respond_to do |format|
      if @movie_celebrity.update(movie_celebrity_params)
        format.html { redirect_to @movie_celebrity, notice: 'Movie celebrity was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie_celebrity }
      else
        format.html { render :edit }
        format.json { render json: @movie_celebrity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_celebrities/1
  # DELETE /movie_celebrities/1.json
  def destroy
    @movie_celebrity.destroy
    respond_to do |format|
      format.html { redirect_to movie_celebrities_url, notice: 'Movie celebrity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_celebrity
      @movie_celebrity = MovieCelebrity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_celebrity_params
      params.require(:movie_celebrity).permit(:movie_id, :celebrity_id, :name, :role)
    end
end
