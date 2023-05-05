class Api::V1::PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    # query for all the posts that the user made
    @posts = User.find(current_user.id).posts
    render json: {
      posts: @posts.as_json(include: :images)
    }
  end

  def create
    begin
      data = post_params
      created_post_response = Posts::Creator.new(
        user_id: current_user.id,
        post_content: data[:content],
        images: data[:images]
      ).call

    rescue StandardError => exception
      # ArcadiaLogger.error("Error creating ingestion request: #{exception.message}")
      return render json: { error: exception.message }, status: :unprocessable_entity
    end

    # TODO: trigger event to update the users feeds when the current_user posts
    # if @post and @images
    #   @post.trigger_event(@post.id)
    # end

    render json: {
      post: created_post_response
    }
  end

  def destroy
    # Destroy the images, comments, likes associated to this post and finally delete the post
    # TODO: check the implementation of all active record delete methods
    begin
      deleted_post = Posts::Destroyer.new(
        post_id: params[:id]
      ).call

    rescue StandardError => exception
      return render json: { error: exception.message }, status: :unprocessable_entity
    end

    render json: {
      message: "Post deleted successfully",
    }, status: :ok
  end

  # edit and delete posts too
  private
  #TODO: LOOK INTO STRONG PARAMS
  def post_params
    params.require(:post).permit(:content, images:[] )
  end
end
