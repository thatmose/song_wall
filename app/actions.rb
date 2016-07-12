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
  if @user.save
    redirect "/users"
  else
    erb :"registrations/signup"
  end
end

get "/users" do
  erb :"/users/home"
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
    url: params[:url] 
    )
  if @song.save
    redirect "/songs"
  else
    erb :"songs/new"
  end
end
