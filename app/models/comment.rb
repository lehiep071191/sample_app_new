class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :micropost
	validates :content, presence: true , length: {maximum: 255}
	after_create :listen_comment

	def listen_comment
		CommentBroadcastJob.perform_now(self)
	end
end
