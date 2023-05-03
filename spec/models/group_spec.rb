require 'rails_helper'

RSpec.describe Group, type: :model do

  before(:each) do
    let!(user) {create(:user)} # group creator
  end

  context "create a group with a few users" do
    let!(:user1) {create(:user)}
    let!(:user2) {create(:user)}
    let!(:user3) {create(:user)}

  end
end
