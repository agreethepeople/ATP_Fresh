include ActionView::Helpers::TextHelper
include TopicsHelper
#require 'ruby-bitly'

class TopicsController < ApplicationController

  before_filter :signed_in_user, only: [:agreements]



  respond_to :html, :js

  def index
    #all the topics
    @topics = Topic.paginate(page: params[:page])
  end

  def show
    #one topic main page
    @topic = Topic.find_by_slug(params[:slug])
    flash[:notice] = "Sign in to have your votes counted. Anything you agree with is private to you." unless signed_in?
    @user = current_user if signed_in?
    if (params[:agreement])
      alex = Agreement.find(params[:agreement])
      if alex.topic_id == @topic.id
        @agreement = alex
        return
      end
    end
    @agreement = generate_agreement_for unless @topic.agreements.count==0
  end

  def analysis
    @topic = Topic.find_by_slug(params[:slug])
  end

  def agreements
    @topic = Topic.find_by_slug(params[:slug])
    @agreements = @topic.agreements.order('created_at DESC')
  end


  private
    
    def signed_in_user
      unless signed_in?
        #store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end



end


