namespace :db do
	desc "Fill database with parsed Vine data"
	task :populate => :environment do
		make_videos
	end
end

def make_videos
	require 'nokogiri'
	require 'open-uri'

	array = ["loop","funniest","funny","best"]  #["party", "dance", "yolo", "cats", "NBA", "cinco de mayo", "sexy", "fail", "tyler the creator", "riff raff", "will saso", "funniest"] #%w[hiphop tyler funniest NBA twerk trending] #["tyler the creator", "riff raff", "will saso", "funniest"] #%w[yolo loop NBA vegas sexy fail] #%w[yolo dance music NBA dog cats]
	array.each do |value|
		results = Twitter.search("#{value} vine", :result_type => "popular")
		results.attrs[:statuses].each do |x|
			begin
				url = x[:entities][:urls][0][:expanded_url]
				if url.split('/')[2] == "vine.co"		#make sure url is Vine
					puts "Beginning fetching vine document..."
					doc = Nokogiri::HTML(open(url))
					vine_s3_url 				= doc.css('div .video-container .video-js source')[0]["src"]
					vine_user_image_url = doc.css('div .info .user img')[0]["src"]
					username 						= doc.css('div .info .user h2').text
					description					= doc.css('div .info h1 .inner p').text
					puts "Ending fetching vine document..."
					Video.create!(:description => description, :username => username, :vine_s3_url => vine_s3_url, :vine_user_image_url => vine_user_image_url, :vine_url => url)
					#Video.create!(:vine_url => url)
				end
			rescue
				puts "shit"
			end
		end
	end
end