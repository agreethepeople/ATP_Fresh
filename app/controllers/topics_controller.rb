include ActionView::Helpers::TextHelper
include TopicsHelper
#require 'ruby-bitly'
require 'will_paginate/array'




class TopicsController < ApplicationController

  before_filter :signed_in_user, only: [:agreements]
  before_filter :admin_user, only: [:create]

  respond_to :html, :js

  def index
    #all the topics
     sorted = Topic.all.sort_by { |topic| topic.agreements.count }
      @topics = sorted.reverse.paginate(page: params[:page], :per_page => 20)
      @suggested_topic = SuggestedTopic.new

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



  def create
    puts params
    newTopic = Topic.new
    title = params[:title]
    if newTopic.make_safe_topic(title)
      flash[:success] = "added #{title}!" 
    else
      flash[:failure] = "something went wrong"
    end

    #also destroy the suggestion
    suggestion = SuggestedTopic.find_by_title(title)
    suggestion.destroy if suggestion

    redirect_to suggested_topics_path
  end



  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end


end


