class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :description
      t.string :username
      t.string :vine_id
      t.string :vine_s3_url
      t.string :vine_user_image_url

      t.timestamps
    end
  end
end
