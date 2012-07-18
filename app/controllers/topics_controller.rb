include ActionView::Helpers::TextHelper
include TopicsHelper
#require 'ruby-bitly'

class TopicsController < ApplicationController

  respond_to :html, :js

  def index
    #all the topics
    @topics = Topic.paginate(page: params[:page])
  end

  def show
    #one topic main page
    @topic = Topic.find_by_slug(params[:slug])
    flash[:notice] = "Sign in to have your votes counted!" unless signed_in?
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
    puts "big ol' list of all the agreements"
  end



end


