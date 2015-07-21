class MovieTypesController < ApplicationController
  before_action :set_movie_type, only: [:show, :edit, :update, :destroy]

  # GET /movie_types
  # GET /movie_types.json
  def index
    @movie_types = MovieType.all
  end

  # GET /movie_types/1
  # GET /movie_types/1.json
  def show
  end

  # GET /movie_types/new
  def new
    @movie_type = MovieType.new
  end

  # GET /movie_types/1/edit
  def edit
  end

  # POST /movie_types
  # POST /movie_types.json
  def create
    @movie_type = MovieType.new(movie_type_params)

    respond_to do |format|
      if @movie_type.save
        format.html { redirect_to @movie_type, notice: 'Movie type was successfully created.' }
        format.json { render :show, status: :created, location: @movie_type }
      else
        format.html { render :new }
        format.json { render json: @movie_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_types/1
  # PATCH/PUT /movie_types/1.json
  def update
    respond_to do |format|
      if @movie_type.update(movie_type_params)
        format.html { redirect_to @movie_type, notice: 'Movie type was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie_type }
      else
        format.html { render :edit }
        format.json { render json: @movie_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_types/1
  # DELETE /movie_types/1.json
  def destroy
    @movie_type.destroy
    respond_to do |format|
      format.html { redirect_to movie_types_url, notice: 'Movie type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_type
      @movie_type = MovieType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_type_params
      params.require(:movie_type).permit(:movie_id, :type_id, :name)
    end
end
