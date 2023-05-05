module Posts
  class Creator
    attr_reader :user_id, :post_content, :post
    def initialize(user_id:, post_content:, images:)
      @user_id = user_id
      @post_content = post_content
      @images = images
    end

    def call
      create_post
    end

    private
    def create_post
      ActiveRecord::Base.transaction do
        @post = Post.create!(
          user: User.find(user_id),
          content: post_content
        )
        create_images
        byebug
        @post.as_json(include: :images)
      end
    end

    def create_images
      @images.each do |image|
        @post.images.create!(
          url: image
        )
      end
      @post.images
    end
  end
end