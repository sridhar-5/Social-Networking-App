require 'rails_helper'

RSpec.describe Post, type: :model do
  context "create post" do

    #create user
    let(:user_1) { build(:user) }
    let(:post) { build(:post, user: user_1) }

    it "create post successfully" do
      expect(user_1.posts.count).to eq(0)
      post.save!
      expect(user_1.posts.count).to eq(1)
    end
  end


  context "deletion of post" do
    let!(:user) { create(:user) }
    let!(:user_1) { create(:user) }
    # creating posts for user
    let!(:post_1) { create(:post, user: user) }
    let!(:post_2) { create(:post, user: user_1) }

    #creating images for posts
    let!(:image_1) {create(:image, post: post_1)}
    let!(:image_2) { create(:image, post: post_1)}
    let!(:image_3) { create(:image, post: post_2)}

    #creating likes for user
    let!(:like_1) { create(:reaction, user: user, post: post_1, reaction_type: like) }
    let!(:like_2) { create(:reaction, user: user, post: post_2, reaction_type: like) }

    # creating comments for user
    let!(:comment_1) { create(:comment, user: user, post: post_1 ) }
    let!(:comment_2) { create(:comment, user: user, post: post_2 ) }


    it "dependent destroy if post is deleted" do
      expect(user.posts.count).to eq(1)
      expect(user_1.posts.count).to eq(1)
      expect(post_1.images.count).to eq(2)
      expect(post_2.images.count).to eq(1)
      expect(post_1.reactions.count).to eq(1)
      expect(post_2.reactions.count).to eq(1)
      expect(post_1.comments.count).to eq(1)
      expect(post_2.comments.count).to eq(1)

      post_1.destroy!
      post_2.destroy!

      expect(user.posts.count).to eq(0)
      expect(user_1.posts.count).to eq(0)
      expect(post_1.images.count).to eq(0)
      expect(post_2.images.count).to eq(0)
      expect(post_1.reactions.count).to eq(0)
      expect(post_2.reactions.count).to eq(0)
      expect(post_1.comments.count).to eq(0)
      expect(post_2.comments.count).to eq(0)
    end
  end
end
