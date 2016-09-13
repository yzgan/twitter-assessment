enable :sessions

get '/' do
	if logged_in? then
		redirect '/homepage'
	else
  		erb :"static/index"
	end
end


post '/login' do
	puts "login controller"
	user = User.find_by_email(params[:user][:email])
	password = params[:user][:password]
	email = params[:user][:email]
	password_auth = BCrypt::Password.new(user.password_digest)

	if password_auth != password
		redirect '/'
	else
		session[:user_id] = user.id
		redirect '/homepage'
		
	end
end

post '/logout' do
	session[:user_id] = nil
	redirect '/'
end

post '/signup' do
	puts "sign up controller"
	user = User.new(params[:user])
	# byebug
	if user.save
		puts "user registered"
		session[:user_id] = user.id
		redirect '/homepage'
	else
		redirect '/'
	end
end

get '/homepage' do
	@tweets = Tweet.all
	puts "current user id: #{session[:user_id]}" 
	logged_in_redirect(:"static/homepage", "/")
end

get '/user/:id' do
	@user = User.find(params["id"])
	@follower = Follower.where(user_id_followed: params[:id])
	@following = Follower.where(user_id_following: params[:id])
	@tweet = @user.tweets
	# @show_user_detail = @follower.where(user_id_following: current_user.id).count == 0

	@show = @user.show_detail?(@follower, current_user)
	logged_in_redirect(:"static/user/profile", '/')
end

post '/user/:id/edit' do
	user = User.find(params[:id])
	user.name = params[:user][:name]
	user.password = params[:user][:password]
	user.email = params[:user][:email]
	user.save
	# redirect '/user/'+params[:id]
	logged_in_redirect('/user/'+params[:id], '/')
end

post '/user/:id/follow' do
	follow = Follower.new(user_id_following: params[:follower][:user_id_following], user_id_followed: params[:follower][:user_id_followed])
	follow.save
	# redirect '/user/'+params[:id]
	logged_in_redirect('/user/'+params[:id], '/')
end

get '/user/:id/tweets' do
	@tweets = Tweet.where(user_id: params[:id])
	logged_in_redirect(:"static/user/user_tweet", '/')
end


get '/tweet/:id' do 
	@tweet = Tweet.find(params[:id])
	logged_in_redirect(:"static/tweet/tweet", '/')
end

post '/tweet/new' do
	tweet_new = Tweet.new(subject: params[:tweet][:subject])
	tweet_new.user = current_user
	tweet_new.save
	redirect '/'
end

post '/tweet/:id/edit' do
	tweet = Tweet.find(params[:id])
	tweet.subject = params[:tweet][:subject]
	tweet.save
	# redirect '/tweet/'+params[:id]  
	logged_in_redirect('/tweet/'+params[:id], '/')
end


post '/tweet/:id/delete' do
	Tweet.destroy(params[:id])
	redirect '/homepage'
end


