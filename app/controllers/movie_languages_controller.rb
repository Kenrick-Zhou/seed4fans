class MovieLanguagesController < ApplicationController
  before_action :set_movie_language, only: [:show, :edit, :update, :destroy]

  # GET /movie_languages
  # GET /movie_languages.json
  def index
    @movie_languages = MovieLanguage.all
  end

  # GET /movie_languages/1
  # GET /movie_languages/1.json
  def show
  end

  # GET /movie_languages/new
  def new
    @movie_language = MovieLanguage.new
  end

  # GET /movie_languages/1/edit
  def edit
  end

  # POST /movie_languages
  # POST /movie_languages.json
  def create
    @movie_language = MovieLanguage.new(movie_language_params)

    respond_to do |format|
      if @movie_language.save
        format.html { redirect_to @movie_language, notice: 'Movie language was successfully created.' }
        format.json { render :show, status: :created, location: @movie_language }
      else
        format.html { render :new }
        format.json { render json: @movie_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_languages/1
  # PATCH/PUT /movie_languages/1.json
  def update
    respond_to do |format|
      if @movie_language.update(movie_language_params)
        format.html { redirect_to @movie_language, notice: 'Movie language was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie_language }
      else
        format.html { render :edit }
        format.json { render json: @movie_language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_languages/1
  # DELETE /movie_languages/1.json
  def destroy
    @movie_language.destroy
    respond_to do |format|
      format.html { redirect_to movie_languages_url, notice: 'Movie language was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_language
      @movie_language = MovieLanguage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_language_params
      params.require(:movie_language).permit(:movie_id, :language_id, :name)
    end
end
