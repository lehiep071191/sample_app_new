class CommentsController < ApplicationController
	before_action :set_comment, only: :destroy
	def create
		@comment = Comment.new(content: params[:content], user_id: params[:user_id], micropost_id: params[:micropost_id])
		if @comment.save!
			render json: {
				data_comment: render_to_string(@comment)
			}, status: :ok
		end	
	end
	
	def destroy

	end

	private
	def comment_params
		params.require(:comment).permit(:content )
	end	
	def set_comment
		@comment = Comment.find_by id: params[:id]
	end	

end
