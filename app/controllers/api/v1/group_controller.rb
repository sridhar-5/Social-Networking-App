class Api::V1::GroupController < ApplicationController
  before_action :authenticate_user!

  def index
    # group feed

  end

  def create
    data = group_params
    ActiveRecord::Base.transaction do
      @group = Group.create!(
        { "name" => data['name'],
          "description" => data["description"],
          "image_url" => data["image_url"],
          "user" => User.find(current_user.id)
        }
      )
      # assigning admin role to the group creator
      @set_permission = GroupPermission.create!({"user" => current_user, "group" => @group, "role" => "admin"})

      # assigning all other members of the group with an member role
      data["user_ids"].each do |user_id|
        user = User.find(user_id)
        @group.users << user
        @set_permission = GroupPermission.create!({"user" => user, "group" => @group, "role" => :member})
      end
    end

    render json: {
      status: :created,
      group: @group
    }
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :image_url, user_ids:[])
  end
end
