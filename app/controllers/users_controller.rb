include ActionView::Helpers::TextHelper


class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :not_signed_in, only: [:new, :create]


  def show
   @user = User.find(params[:id])
   #find all of these
   @authored_agreements = Agreement.find(:all, :conditions => "user_id = '#{@user.id}'")
   #_by_user_id(@user.id)
   #@agreed_agreements = ...
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Agree the People!"
      redirect_to root_path #load up the root home page
    else
      render 'new' #reloads the signup page to show all the error messages
    end
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      #successful update
      flash[:success] = "Profile updated"
      sign_in @user
        #need to sign in again because the remember token gets reset
      redirect_to @user
    else
      #unsuccessful
      render 'edit'
    end
  end

  def destroy
    if !current_user?(User.find(params[:id]))
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end


  private
    
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def not_signed_in
      redirect_to root_path unless !signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
