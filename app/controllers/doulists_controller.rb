class DoulistsController < ApplicationController
  before_action :set_doulist, only: [:show, :edit, :update, :destroy]

  # GET /doulists
  # GET /doulists.json
  def index
    @doulists = Doulist.all
  end

  # GET /doulists/1
  # GET /doulists/1.json
  def show
  end

  # GET /doulists/new
  def new
    @doulist = Doulist.new
  end

  # GET /doulists/1/edit
  def edit
  end

  # POST /doulists
  # POST /doulists.json
  def create
    @doulist = Doulist.new(doulist_params)

    respond_to do |format|
      if @doulist.save
        format.html { redirect_to @doulist, notice: 'Doulist was successfully created.' }
        format.json { render :show, status: :created, location: @doulist }
      else
        format.html { render :new }
        format.json { render json: @doulist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doulists/1
  # PATCH/PUT /doulists/1.json
  def update
    respond_to do |format|
      if @doulist.update(doulist_params)
        format.html { redirect_to @doulist, notice: 'Doulist was successfully updated.' }
        format.json { render :show, status: :ok, location: @doulist }
      else
        format.html { render :edit }
        format.json { render json: @doulist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doulists/1
  # DELETE /doulists/1.json
  def destroy
    @doulist.destroy
    respond_to do |format|
      format.html { redirect_to doulists_url, notice: 'Doulist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doulist
      @doulist = Doulist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doulist_params
      params.require(:doulist).permit(:movie_id, :name, :dlist_id, :uname)
    end
end
