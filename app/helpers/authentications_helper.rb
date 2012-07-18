module AuthenticationsHelper

	def sign_in(user)
		session[:user_id]=user.id
		current_user=(user)
	end

	def is_admin?
	 	signed_in? ? current_user.admin : false
	end

	def signed_in?
		!current_user.nil?
	end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to root_path, notice: "Please sign in."
      end
    end
    
	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_id(session[:user_id])
	end

	def sign_out
		self.current_user = nil
		session[:user_id] = nil
	end

	def current_user?(user)
		user==current_user
	end
	
	def redirect_back_or(default)
		#redirect_to(session[:return_to] || default)
		#session.delete(:return_to)
	end

	def store_location
		#session[:return_to] = request.fullpath
	end
end


