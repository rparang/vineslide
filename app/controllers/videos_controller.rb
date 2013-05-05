class VideosController < ApplicationController
	respond_to :json

  def index
    respond_with Video.limit 10
  end

  def show
    respond_with Video.find(params[:id])
  end

  def create
    respond_with Video.create(params[:video])
  end

  def update
    respond_with Video.update(params[:id], params[:video])
  end

  def destroy
    respond_with Video.destroy(params[:id])
  end
end
