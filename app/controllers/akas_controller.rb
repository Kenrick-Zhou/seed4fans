class AkasController < ApplicationController
  before_action :set_aka, only: [:show, :edit, :update, :destroy]

  # GET /akas
  # GET /akas.json
  def index
    @akas = Aka.all
  end

  # GET /akas/1
  # GET /akas/1.json
  def show
  end

  # GET /akas/new
  def new
    @aka = Aka.new
  end

  # GET /akas/1/edit
  def edit
  end

  # POST /akas
  # POST /akas.json
  def create
    @aka = Aka.new(aka_params)

    respond_to do |format|
      if @aka.save
        format.html { redirect_to @aka, notice: 'Aka was successfully created.' }
        format.json { render :show, status: :created, location: @aka }
      else
        format.html { render :new }
        format.json { render json: @aka.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /akas/1
  # PATCH/PUT /akas/1.json
  def update
    respond_to do |format|
      if @aka.update(aka_params)
        format.html { redirect_to @aka, notice: 'Aka was successfully updated.' }
        format.json { render :show, status: :ok, location: @aka }
      else
        format.html { render :edit }
        format.json { render json: @aka.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /akas/1
  # DELETE /akas/1.json
  def destroy
    @aka.destroy
    respond_to do |format|
      format.html { redirect_to akas_url, notice: 'Aka was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aka
      @aka = Aka.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aka_params
      params.require(:aka).permit(:movie_id, :aka)
    end
end
