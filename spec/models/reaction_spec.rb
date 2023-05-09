require 'rails_helper'

RSpec.describe Reaction, type: :model do

  context "create reaction" do
    let(:user) { create(:user) }
    let(:post_1) { create(:post, user: user) }
    let(:reaction_1) { create(:reaction, user: user, post: post_1) }

    it "reaction created" do
      expect(reaction_1.valid?).to eq(true)
    end
  end

  context "when reaction is deleted" do
    let(:user) { create(:user) }
    let(:post_1) { create(:post, user: user) }
    let(:reaction_1) { create(:reaction, user: user, post: post_1) }
    let(:reaction_2) { create(:reaction, user: user, post: post_1) }

    it "reaction deleted" do
      expect(post_1.reactions.count).to eq(2)
      reaction_1.destroy
      expect(post_1.reactions.count).to eq(1)
    end
  end

  context "association tests" do
    it {should belong_to(:user)}
    it {should belong_to(:post)}
  end
end
