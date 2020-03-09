class StaticPagesController < ApplicationController
  def home
    @topic = Topic.new
    #@topics = Topic.all
    @topics = params[:tag_id].present? ? Tag.find(params[:tag_id]).topics : Topic.all
    @topics = @topics.page(params[:page]).per(20)
  end
end
