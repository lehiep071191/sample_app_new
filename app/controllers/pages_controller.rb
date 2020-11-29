class PagesController < ApplicationController
	def index
		if logged_in?
			@micropost = current_user.microposts.build
			@comments = @micropost.comments
			@feed_items = current_user.feed.order_by_time.paginate(page: params[:page])
		end
	end	
end
