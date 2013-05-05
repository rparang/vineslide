class AddVineUrlToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :vine_url, :string
  end
end
