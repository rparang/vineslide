class VideosController < ApplicationController
	respond_to :json
  require 'nokogiri'
  require 'open-uri'

  def index
    respond_with Video.all
  end

  def show
    respond_with Video.find(params[:id])
  end

  def create
    url = params[:video][:vine_url]
    Rails.logger.debug("My object: #{url}")
    puts "Beginning fetching vine document..."
    doc = Nokogiri::HTML(open(url))
    vine_s3_url         = doc.css('div .video-container .video-js source')[0]["src"]
    vine_user_image_url = doc.css('div .info .user img')[0]["src"]
    username            = doc.css('div .info .user h2').text
    description         = doc.css('div .info h1 .inner p').text
    puts "Ending fetching vine document..."
    respond_with Video.create(:description => description, :username => username, :vine_s3_url => vine_s3_url, :vine_user_image_url => vine_user_image_url, :vine_url => url)

    #respond_with Video.create(params[:video])
  end

  def update
    respond_with Video.update(params[:id], params[:video])
  end

  def destroy
    respond_with Video.destroy(params[:id])
  end
end
