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

      #i think this works, need to test with more users
      puts User.all
      users = User.all#Array.new(1) { Array.new(2) }
      sorted = users.sort_by { |user| user.points }
      puts sorted


      @users = User.paginate(page: params[:page])
  end


  def edit
    @user = current_user
  end

  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      #successful update
      @user.email == "replace-me-please@example.com" ?  flash[:success] = "Profile Updated" : flash[:success] = "Thanks for updating your email."
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
