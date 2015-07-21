class MovieTagsController < ApplicationController
  before_action :set_movie_tag, only: [:show, :edit, :update, :destroy]

  # GET /movie_tags
  # GET /movie_tags.json
  def index
    @movie_tags = MovieTag.all
  end

  # GET /movie_tags/1
  # GET /movie_tags/1.json
  def show
  end

  # GET /movie_tags/new
  def new
    @movie_tag = MovieTag.new
  end

  # GET /movie_tags/1/edit
  def edit
  end

  # POST /movie_tags
  # POST /movie_tags.json
  def create
    @movie_tag = MovieTag.new(movie_tag_params)

    respond_to do |format|
      if @movie_tag.save
        format.html { redirect_to @movie_tag, notice: 'Movie tag was successfully created.' }
        format.json { render :show, status: :created, location: @movie_tag }
      else
        format.html { render :new }
        format.json { render json: @movie_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_tags/1
  # PATCH/PUT /movie_tags/1.json
  def update
    respond_to do |format|
      if @movie_tag.update(movie_tag_params)
        format.html { redirect_to @movie_tag, notice: 'Movie tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie_tag }
      else
        format.html { render :edit }
        format.json { render json: @movie_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_tags/1
  # DELETE /movie_tags/1.json
  def destroy
    @movie_tag.destroy
    respond_to do |format|
      format.html { redirect_to movie_tags_url, notice: 'Movie tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_tag
      @movie_tag = MovieTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_tag_params
      params.require(:movie_tag).permit(:movie_id, :tag_id, :name)
    end
end
