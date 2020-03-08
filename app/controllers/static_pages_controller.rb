class StaticPagesController < ApplicationController
  def home
    @topic = Topic.new
    #@topics = Topic.all
    @topics = Topic.page(params[:page]).per(20)
  end
end
