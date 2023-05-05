module UserFeed
  class FeedGenerator

    attr_reader :user
    def initialize(user)
      @user = user
    end

    def call
      get_feed
    end

    private

    def get_friend
      friends = Friendship.select('user_id', 'friend_id')
                          .where(user_id: user.id)
                          .or(Friendship.where(friend_id: user.id))
                          .distinct
      ids = []
      friends.each do |friend|
        if friend.user_id == user.id
          ids << friend.friend_id
        else
          ids << friend.user_id
        end
      end
      ids
    end

    def get_feed
      # this is one way to query for the images get posts -> iterate over posts and get images for each post
      # @posts = Post.where(user_id: get_friend).order(created_at: :desc)
      # post_data = @posts.map do |post|
      #   images = Image.where(post_id: post.id)
      #   {
      #     id: post.id,
      #     content: post.content,
      #     created_at: post.created_at,
      #     images: images
      #   } - 110ms response time

      posts = Post.joins(:images)
                   .where(user_id: get_friend)
                   .order(created_at: :desc)
                   .select("posts.id, posts.content, posts.created_at, string_agg(images.url, ',') as images")
                   .group('posts.id')    # 70 ms response time
    end
  end
end