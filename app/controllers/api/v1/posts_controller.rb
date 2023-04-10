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
    data = post_params
    @post = Post.create!({"content"=> data["content"], "user" => User.find(current_user.id) })
    images = []
    data["images"].each do |image|
      images << {"url" => image, "post" => @post}
    end
    @images = Image.create!(images)
    render json: {
      post: @post.as_json(include: :images)
    }
  end

  # edit and delete posts too
  private

  def post_params
    params.require(:post).permit(:content, images:[] )
  end
end
