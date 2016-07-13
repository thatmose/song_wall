enable :sessions

helpers do
  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  def can_vote?
    result = Vote.where("song_id = ? AND user_id = ?",params[:song_id],current_user.id)
    p result.empty?
    result.empty?
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
    puts "Account created!"
    redirect "/sessions/login"
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
    redirect "/users"
  else
    erb :"/sessions/login"
  end
end

get "/users" do
  current_user
  erb :"/users/index"
end

get "/songs" do
  @songs = Song.all.order(num_upvotes: :desc)
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

post "/upvote" do
  if can_vote?
    @vote = Vote.new(
      song_id: params[:song_id],
      user_id: current_user.id,
      upvote: true)
      if @vote.save!
        @vote.song.num_upvotes += 1
        @vote.song.save!
        puts "Saved"
        redirect "/songs"
      else
        puts "Bad"
        redirect "/songs"
      end
    else
      puts "Sorry but you already voted"
      redirect "/songs"
  end
end
