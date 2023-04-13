class HomeController < ApplicationController
  def index
    render :json => "Hello World"
  end
end

# user is not authenticated redirect him to the login page