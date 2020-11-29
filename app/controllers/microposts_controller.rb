class MicropostsController < ApplicationController
	before_action :set_micropost, only: [:edit,:update, :destroy]
	before_action :correct_user, only: [:edit, :update, :destroy]
	def new
	end
	def create
		@micropost  = current_user.microposts.build(micropost_params)
		if @micropost.save!
			respond_to do |format|
				format.html{redirect_to root_url}
				format.json
			end
		else 
			@feed_items = current_user.feed.paginate(page: params[:page])
			render 'pages/index'	
		end	
	end
	def edit
	end
	def update

	end	
	def destroy
		@micropost.destroy
		respond_to do |format|
			format.html{redirect_to root_url}
			format.json
		end	
	end	
	private
	def micropost_params
		params.require(:micropost).permit(:content, :image)
	end	
	def set_micropost
		@micropost = Micropost.find_by id: params[:id]
		if @micropost.nil?
			flash[:danger] = "micropost not found"
			redirect_to root_url
		end	
	end	
	def correct_user
		@micropost = current_user.microposts.find_by(id: params[:id])
		redirect_to root_url if @micropost.nil?
	end

end
