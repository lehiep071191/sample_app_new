class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :check_login, only: :new
  before_action :correct_user, only: [:edit,:update] 
  before_action :logged_in_user, only: [ :index,:edit,:update,:show]
  def index
    @users = User.all.paginate(page: params[:page], per_page: 20)
  end		
  def new
  	@user = User.new
  end
  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
    	flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
	else
		render 'new'
	end
  end	
  def show
  end
  def edit
  end
  def update
    if @user.update! user_params
      flash[:success] = "account updated!"
      redirect_to @user
    end  
  end  
  private 
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end	
  def set_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = 'user not found'
      redirect_to root_url
    end  
  end 
  def check_login
    if current_user.present?
      redirect_to root_url 
      flash[:danger] = "you are logging"
    end  
  end 
  def correct_user
    redirect_to root_url unless current_user.current_user?(@user)
  end  
end
