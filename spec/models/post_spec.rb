require 'rails_helper'

RSpec.describe Post, type: :model do
  context "association tests" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:images) }
  end
end
