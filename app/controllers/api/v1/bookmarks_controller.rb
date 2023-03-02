class Api::V1::BookmarksController < ApplicationController
  before_action :authenticate_api_v1_user!, except: [ :index ]
  before_action :set_post, only: [ :create ]
  before_action :set_bookmark, only: [ :destroy ]
  before_action :check_owner, only: [ :destroy ]

  # GET /bookmarks
  def index
    @bookmarks = current_api_v1_user.bookmarks

    render json: @bookmarks
  end

  # POST /bookmarks
  def create
    @bookmark = current_api_v1_user.bookmarks.new(bookmark_params)
    @bookmark.post = @post

    if @bookmark.save
      render json: @bookmark, status: :created
    else
      render json: @bookmark.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bookmarks/1
  def destroy
    @bookmark.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by_id(params[:post_id])
      
      render json: {
        message: 'Post not found'
      }, status: :not_found if @post.nil?
    end

    def set_bookmark
      @bookmark = Bookmark.find_by_id(params[:id])
      
      render json: {
        message: 'Bookmark not found'
      }, status: :not_found if @bookmark.nil?
    end

    def check_owner
      render json: {
        message: 'Unauthorized action'
      }, status: :unauthorized unless current_api_v1_user.id == @bookmark.user_id
    end

    # Only allow a list of trusted parameters through.
    def bookmark_params
      params.require(:bookmark).permit(:post_id)
    end
end
