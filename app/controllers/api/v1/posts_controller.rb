class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_v1_user!, except: [ :index, :show ]
  before_action :set_post, only: %i[ show update destroy ]
  before_action :check_owner, only: %i[ edit update destroy ]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = current_api_v1_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_id(params[:id])

      render json: {
        message: 'Post not found'
      }, status: :not_found if @post.nil?
    end

    def check_owner
      render json: {
        message: 'Unauthorized action'
      }, status: :unauthorized unless current_api_v1_user.id == @post.user_id
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :tag_list)
    end
end
