class NewCommentsController < ApplicationController
  before_action :set_new_comment, only: [:show, :edit, :update, :destroy]

  # GET /new_comments
  # GET /new_comments.json
  def index
    @new_comments = NewComment.all
  end

  # GET /new_comments/1
  # GET /new_comments/1.json
  def show
  end

  # GET /new_comments/new
  def new
    @new_comment = NewComment.new
  end

  # GET /new_comments/1/edit
  def edit
  end

  # POST /new_comments
  # POST /new_comments.json
  def create
    @new_comment = NewComment.new(new_comment_params)

    respond_to do |format|
      if @new_comment.save
        format.html { redirect_to @new_comment, notice: 'New comment was successfully created.' }
        format.json { render :show, status: :created, location: @new_comment }
      else
        format.html { render :new }
        format.json { render json: @new_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /new_comments/1
  # PATCH/PUT /new_comments/1.json
  def update
    respond_to do |format|
      if @new_comment.update(new_comment_params)
        format.html { redirect_to @new_comment, notice: 'New comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @new_comment }
      else
        format.html { render :edit }
        format.json { render json: @new_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /new_comments/1
  # DELETE /new_comments/1.json
  def destroy
    @new_comment.destroy
    respond_to do |format|
      format.html { redirect_to new_comments_url, notice: 'New comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_comment
      @new_comment = NewComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def new_comment_params
      params.require(:new_comment).permit(:movie_id, :did, :name, :rating, :pubdate, :comment)
    end
end
