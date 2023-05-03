require 'rails_helper'

RSpec.describe Comment, type: :model do

    context "create comment" do
      let(:user) { create(:user) }
      let(:post_1) { create(:post, user: user) }
      let(:comment_1) { create(:comment, user: user, post: post_1) }

      it "comment created" do
        expect(comment_1.valid?).to eq(true)
      end
    end

    context "when comment is deleted" do
      let!(:user) { create(:user) }
      let!(:post_1) { create(:post, user: user) }
      let!(:comment_1) { create(:comment, user: user, post: post_1) }
      let!(:comment_2) { create(:comment, user: user, post: post_1) }

      it "comment deleted" do
        expect(post_1.comments.count).to eq(2)
        comment_1.destroy
        expect(post_1.comments.count).to eq(1)
      end
    end

    context "association tests" do
      it {should belong_to(:user)}
      it {should belong_to(:post)}
    end

    context "comment content check" do
      let(:user) { create(:user) }
      let(:post_1) { create(:post, user: user) }
      let(:comment_1) { create(:comment, user: user, post: post_1) }
      let(:comment_2) { create(:comment, user: user, post: post_1) }

      it "comment content is not empty" do
        expect(comment_1.content).to_not eq(nil)
      end

      it "comment content is not too long" do
        expect(comment_1.content.length).to be < 1000
      end

      it "comment content is not too short" do
        expect(comment_1.content.length).to be >= 1
      end
    end

    context "comment content failure specs" do

      let(:user) { create(:user) }
      let(:post_1) { create(:post, user: user) }
      let(:comment_1) { build(:comment, user: user, post: post_1, content: nil) }
      let(:comment_2) { build(:comment, user: user, post: post_1, content: "") }
      let(:comment_3) { build(:comment, user: user, post: post_1, content: "a" * 1001) }

      it "fail if comment content is empty" do
        expect{comment_1.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "fail if comment content is too short" do
        expect{comment_2.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "fail if comment content is too long" do
        expect{comment_3.save!}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
end
