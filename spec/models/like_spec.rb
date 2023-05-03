require 'rails_helper'

RSpec.describe Like, type: :model do

  context "create like" do
    let (:user) { create(:user) }
    let (:post_1) { create(:post, user: user) }
    let (:like_1) { create(:like, user: user, post: post_1) }

    it "like created" do
      expect(like_1.valid?).to eq(true)
    end
  end

  context "when like is deleted" do
    let(:user) { create(:user) }
    let(:post_1) { create(:post, user: user) }
    let(:like_1) { create(:like, user: user, post: post_1) }
    let(:like_2) { create(:like, user: user, post: post_1) }

    it "like deleted" do
      expect(post_1.likes.count).to eq(2)
      like_1.destroy
      expect(post_1.likes.count).to eq(1)
    end
  end

  context "association tests" do
    it {should belong_to(:user)}
    it {should belong_to(:post)}
  end
end
