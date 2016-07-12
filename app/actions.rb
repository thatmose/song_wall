enable :sessions

helpers do
  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end
end

# Homepage (Root path)
get "/" do
  erb :index
end

get "/registrations/signup" do
  erb :"/registrations/signup"
end

post "/registrations" do
  @user = User.new(email: params[:email])
  @user.password = params[:password]
  if @user.save!
    redirect "/users"
  else
    erb :"registrations/signup"
  end
end

get "/sessions/login" do
  erb :"/sessions/login"
end

get "/sessions/logout" do
  session.clear
  redirect "/"
end

post "/sessions" do
  @user = User.find_by_email(params[:email])
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id 
    redirect :"/users"
  else
    erb :"/sessions/login"
  end
end

get "/users" do
  current_user
  erb :"/users/index"
end

get "/songs" do
  @songs = Song.all
  erb :"songs/index"
end

get "/songs/new" do
  erb :"songs/new"
end

post "/songs" do
  @song = Song.new(
    author: params[:author],
    title: params[:title],
    url: params[:url],
    user_id: current_user.id)
  if @song.save
    redirect "/songs"
  else
    erb :"songs/new"
  end
end
