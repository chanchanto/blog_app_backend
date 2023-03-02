class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_api_v1_user!, except: [ :index, :show ]
  before_action :set_post
  before_action :set_comment, only: %i[ show update destroy ]
  before_action :check_owner, only: %i[ edit update destroy ]

  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = current_api_v1_user.comments.new(comment_params)
    @comment.post = @post

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_id(params[:post_id])
      
      render json: {
        message: 'Post not found'
      }, status: :not_found if @post.nil?
    end

    def set_comment
      @comment = Comment.find_by_id(params[:id])
      
      render json: {
        message: 'Comment not found'
      }, status: :not_found if @comment.nil?
    end

    def check_owner
      render json: {
        message: 'Unauthorized action'
      }, status: :unauthorized unless current_api_v1_user.id == @comment.user_id
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
