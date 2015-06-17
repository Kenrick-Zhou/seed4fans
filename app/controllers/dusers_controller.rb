class DusersController < ApplicationController
  before_action :set_duser, only: [:show, :edit, :update, :destroy]

  # GET /dusers
  # GET /dusers.json
  def index
    @dusers = Duser.all
  end

  # GET /dusers/1
  # GET /dusers/1.json
  def show
  end

  # GET /dusers/new
  def new
    @duser = Duser.new
  end

  # GET /dusers/1/edit
  def edit
  end

  # POST /dusers
  # POST /dusers.json
  def create
    @duser = Duser.new(duser_params)

    respond_to do |format|
      if @duser.save
        format.html { redirect_to @duser, notice: 'Duser was successfully created.' }
        format.json { render :show, status: :created, location: @duser }
      else
        format.html { render :new }
        format.json { render json: @duser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dusers/1
  # PATCH/PUT /dusers/1.json
  def update
    respond_to do |format|
      if @duser.update(duser_params)
        format.html { redirect_to @duser, notice: 'Duser was successfully updated.' }
        format.json { render :show, status: :ok, location: @duser }
      else
        format.html { render :edit }
        format.json { render json: @duser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dusers/1
  # DELETE /dusers/1.json
  def destroy
    @duser.destroy
    respond_to do |format|
      format.html { redirect_to dusers_url, notice: 'Duser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_duser
      @duser = Duser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def duser_params
      params.require(:duser).permit(:uid, :name, :c_follower, :c_m_do, :c_m_wish, :c_m_collect, :c_doulist, :error)
    end
end
