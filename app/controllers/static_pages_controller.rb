require 'will_paginate/array'

class StaticPagesController < ApplicationController
  	def home
      sorted = Topic.all.sort_by { |topic| topic.agreements.count }
      @topics = sorted.reverse.paginate(page: params[:page], :per_page => 12)
    end

	def help
	end

	def about
	end

	def contact
	end

end
