class ApplicationController < ActionController::Base
	include SessionsHelper
	def logged_in_user
		unless logged_in?
			flash[:danger] = "You need to be logged in to make this request"
			redirect_to root_url
		end	
	end		
end
