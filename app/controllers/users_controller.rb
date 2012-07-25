include ActionView::Helpers::TextHelper
include AuthenticationsHelper

class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy, :show]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  # before_filter :not_signed_in, only: [:new, :create]


  def show

    puts params

    @user = User.find(params[:id])

    if (@user == current_user)

        @important_topics = Topic.all_of_interest_to(@user)

        #reorder the topics so user can see current relevant one first
        if (params[:topic] && first_topic=Topic.find_by_id(params[:topic]))
          @important_topics = @important_topics - Array.new.unshift(first_topic)
          @important_topics.unshift(first_topic)
        end

        @voted_agreements = Hash.new
        @important_topics.each do |topic|
            @voted_agreements["#{topic.slug}"] = Agreement.all_voted_on_by_user_and_topic(@user, topic)
        end

    else

        @important_topics = Topic.all_written_to(@user)
            
        @authored_agreements = Hash.new
        @important_topics.each do |topic|
            @authored_agreements["#{topic.slug}"] = Agreement.all_written_by_user_on_topic(@user, topic)
        end

    end

  end


  def index
    @users = User.paginate(page: params[:page])
  end


  def edit
    @user = current_user
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      #successful update
      flash[:success] = "Profile Updated"
        #sign_in @user
        #need to sign in again because the remember token gets reset
      redirect_to user_path(@user)
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
        #store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end

    # def not_signed_in
    #   redirect_to root_path unless !signed_in?
    # end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end


  #private


end
