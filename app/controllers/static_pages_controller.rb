class StaticPagesController < ApplicationController
  def home
    @topic =Topic.new
  end

end
