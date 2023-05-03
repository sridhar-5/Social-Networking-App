require 'rails_helper'

RSpec.describe Post, type: :model do
  context "create post" do
    let (:user) { create(:user) }
    let(:post_1) { create(:post, user: user) }

    it "post created" do
      expect(post_1.valid?).to eq(true)
    end
  end

  context "when post is deleted" do
    let!(:user) { create(:user) }

    # create 1 post for user
    let!(:post_1) { create(:post, user: user ) }

    # create 2 images for post_1
    let!(:image_1) { create(:image, post: post_1) }
    let!(:image_2) { create(:image, post: post_1) }

    # create 2 comments for post_1
    let!(:comment_1) { create(:comment, post: post_1) }
    let!(:comment_2) { create(:comment, post: post_1) }

    # create 2 likes for post_1
    let!(:like_1) { create(:like, post: post_1) }
    let!(:like_2) { create(:like, post: post_1) }

    it "post deleted (testing dependent destory)" do
      expect(user.posts.count).to eq(1)
      expect(user.posts.first&.images&.count).to eq(2)
      expect(user.posts.first&.comments&.count).to eq(2)
      expect(user.posts.first&.likes&.count).to eq(2)


      post_1.destroy
      byebug
      expect(user.posts.count).to eq(0)
      expect(post_1.images.count).to eq(0)
      expect(post_1.comments.count).to eq(0)
      expect(post_1.likes.count).to eq(0)
    end
  end

  context "association tests" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:images) }
  end
end
