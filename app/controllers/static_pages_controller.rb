class StaticPagesController < ApplicationController
  def home
    @topic = Topic.new
    # @topics = Topic.all

    @topics = if params[:tag_id].present?
                Tag.find(params[:tag_id]).topics
              elsif params[:search].present?
                Topic.search(params[:search]).includes(:tags, :user)
              else
                Topic.all.includes(:tags, :user)
              end

    # @topics = params[:tag_id].present? ? Tag.find(params[:tag_id]).topics : Topic.all
    # @topics = params[:search].present? ? Topic.search(params[:search]) : Topic.all
    @topics = @topics.page(params[:page]).per(10)
  end
end
