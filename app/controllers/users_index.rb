get '/log_in' do
  # Look in app/views/index.erb
  erb :log_in
end

post '/log_in' do
  if user = User.authenticate(params[:user])
    session[:user_id] = user.id 
    redirect "/secrete_page"
  else
    redirect '/log_in'
  end
end

before '/secrete_page' do
  if session[:user_id].nil?
    redirect '/log_in'
  end
end

get '/secrete_page' do
  # if session[:user_id].nil?
  #   redirect '/'
  # else
    @user = User.find(session[:user_id])
    @url = Url.where(:user_id => session[:user_id])
    erb :user_page
  # end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/log_in'
end

get '/create_user' do

  erb :create_user
end

post '/create_user' do
  user = User.create(params[:user])
  
  if user.valid?
    session[:user_id] = user.id
    redirect '/secrete_page'
  else
    @errors = user.errors.messages
    erb :create_user
  end
end