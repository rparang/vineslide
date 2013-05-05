class Video < ActiveRecord::Base

	default_scope order: 'videos.created_at DESC'

end
