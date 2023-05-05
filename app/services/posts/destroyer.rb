module Posts
  class Destroyer
    attr_reader :user_id, :post_id, :post

    def initialize(post_id:)
      @post_id = post_id
    end
    def call
      destroy_post
    end

    private
    def destroy_post
      @post = Post.find(post_id)
      @post.destroy!
    end
  end
end