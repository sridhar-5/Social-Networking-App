require 'rails_helper'

RSpec.describe User, type: :model do

  # user created
  context "successful user record creation" do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, :admin) }

    it "user created" do
      expect(user.valid?).to eq(true)
    end

    it "should generate an authentication token" do
      expect(user.authentication_token).not_to be_nil
    end

    it "should regenerate auth token when user signs out" do
      old_token = user.authentication_token
      user.authentication_token = nil
      expect(user.authentication_token).not_to eq(old_token)
    end

    it "create admin user" do
      expect(admin_user.isAdmin).to eq(true)
    end
  end

  context "authentication specs" do
    let(:user) { create(:user) }

    it 'authenticates with valid email and password' do
      authenticated_user = User.authenticate(user.email, user.password)
      expect(authenticated_user).to eq(user)
    end

    it 'does not authenticate with invalid password' do
      authenticated_user = User.authenticate(user.email, 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'does not authenticate with invalid email' do
      authenticated_user = User.authenticate('invalidemail@example.com', user.password)
      expect(authenticated_user).to be_nil
    end
  end

  #
  context "test associations" do
    it { should have_many(:group_permissions) }
    it { should have_many(:posts) }
    it { should have_many(:friendships) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friend_requests_from).class_name('FriendRequest').with_foreign_key('friend_request_from_id') }
    it { should have_many(:friend_requests_to).class_name('FriendRequest').with_foreign_key('friend_request_to_id') }
    it { should have_and_belong_to_many(:groups) }
  end

  context "deletion of user" do
    let!(:user) { create(:user) }
    let!(:user_1) { create(:user) }
    # creating posts for user
    let!(:post_1) { create(:post, user: user) }
    let!(:post_2) { create(:post, user: user) }

    # creating likes for user
    let!(:like_1) { create(:like, user: user, post: post_1) }
    let!(:like_2) { create(:like, user: user, post: post_2) }

    # creating comments for user
    let!(:comment_1) { create(:comment, user: user, post: post_1) }
    let!(:comment_2) { create(:comment, user: user, post: post_2) }

    # create groups for user and add users into it
    let!(:group_1) { create(:group, user: user, users: [user]) }
    let!(:group_2) { create(:group, user: user, users: [user]) }
    let!(:group_3) { create(:group, user: user_1, users: [user, user_1]) }

    let!(:group_permission_1) { create(:group_permission, group: group_1, user: user, role: :admin) }
    let!(:group_permission_2) { create(:group_permission, group: group_2, user: user, role: :admin) }
    let!(:group_permission_3) { create(:group_permission, group: group_3, user: user_1, role: :admin) }
    let!(:group_permission_4) { create(:group_permission, group: group_3, user: user, role: :member) }

    # friendships
    let!(:friendship_1) { create(:friendship, user: user, friend: user_1) }

    it "when user gets deleted" do
      expect(user.posts.count).to eq(2)
      expect(user.likes.count).to eq(2)
      expect(user.comments.count).to eq(2)
      expect(user.groups.count).to eq(3)
      expect(user.group_permissions.count).to eq(3)

      user.destroy
      byebug
      expect(user.posts.count).to eq(0)
      expect(user.likes.count).to eq(0)
      expect(user.comments.count).to eq(0)
      expect(user.groups.count).to eq(0)
      expect(user.group_permissions.count).to eq(0)
    end
  end

  # validation failed specs
  context "validation failure specs" do
    let(:user) { build(:user) }
    let(:user_1) { build(:user, name: "some other", username: nil) }
    let(:user_2) { build(:user, name: "some other 2", email: user.email) }
    let(:user_3) { build(:user, email: nil) }

    context "validation failure cases for username" do
      it "user cannot be created without username" do
        expect { user_1.save! }.to raise_error(ActiveRecord::RecordInvalid, /Validation failed/)
      end
    end

    context "validation failure cases for email" do
      it "user cannot exist without email" do
        expect { user_3.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end

      it "email cannot be duplicate (two users cannot have same email)" do
        user.save!
        expect { user_2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
