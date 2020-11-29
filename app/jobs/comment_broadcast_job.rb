class CommentBroadcastJob < ApplicationJob
  queue_as :default

  def perform(comment)
        ActionCable.server.broadcast "comment_channel", 
										content: comment.content,
										username: comment.user.name,
										micropost_id: comment.micropost.id
  end
end
