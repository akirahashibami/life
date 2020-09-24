class VariousesController < ApplicationController
  layout "top"

  def top
    @video = Video.order(created_at: :desc).first
  end

  def about
    # code
  end
end
