class HotCommentsController < ApplicationController
  before_action :set_hot_comment, only: [:show, :edit, :update, :destroy]

  # GET /hot_comments
  # GET /hot_comments.json
  def index
    @hot_comments = HotComment.all
  end

  # GET /hot_comments/1
  # GET /hot_comments/1.json
  def show
  end

  # GET /hot_comments/new
  def new
    @hot_comment = HotComment.new
  end

  # GET /hot_comments/1/edit
  def edit
  end

  # POST /hot_comments
  # POST /hot_comments.json
  def create
    @hot_comment = HotComment.new(hot_comment_params)

    respond_to do |format|
      if @hot_comment.save
        format.html { redirect_to @hot_comment, notice: 'Hot comment was successfully created.' }
        format.json { render :show, status: :created, location: @hot_comment }
      else
        format.html { render :new }
        format.json { render json: @hot_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hot_comments/1
  # PATCH/PUT /hot_comments/1.json
  def update
    respond_to do |format|
      if @hot_comment.update(hot_comment_params)
        format.html { redirect_to @hot_comment, notice: 'Hot comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @hot_comment }
      else
        format.html { render :edit }
        format.json { render json: @hot_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hot_comments/1
  # DELETE /hot_comments/1.json
  def destroy
    @hot_comment.destroy
    respond_to do |format|
      format.html { redirect_to hot_comments_url, notice: 'Hot comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hot_comment
      @hot_comment = HotComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hot_comment_params
      params.require(:hot_comment).permit(:movie_id, :did, :name, :rating, :pubdate, :comment)
    end
end
