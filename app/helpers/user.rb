helpers  do
	# methods defined here are able to be called in any place. 

	def current_user
		if session[:user_id]
			@current_user ||= User.find_by_id(session[:user_id])
		end
	end

	def logged_in?
		!current_user.nil?
	end

	def logged_in_redirect(login_route, redirect_url)
		# byebug
		if logged_in? then
			case 
			when login_route.class == String
				redirect login_route
			when login_route.class == Symbol
				erb login_route
			else
				puts "unrecognized input link"
			end
		else
			case
			when redirect_url.class == String
				redirect redirect_url
			when redirect_url.class == Symbol
				erb redirect_url
			else
				puts "unrecognized input link"
			end
		end
	end
end