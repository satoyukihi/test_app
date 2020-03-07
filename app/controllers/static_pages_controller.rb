class StaticPagesController < ApplicationController
  
  def home
    @topic = Topic.new
    @topics = Topic.all
  end

end
