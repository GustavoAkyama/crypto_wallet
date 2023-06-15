class WelcomeController < ApplicationController
  def index
    cookies[:course] = "Ruby on Rails - Jackson Pires"
    session[:course] = "Ruby on Rails - Jackson Pires"
    @my_name = params[:nome]
    @course = params[:course]
  end
end
