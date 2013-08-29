get '/' do
  @urls = Url.all(:order => "created_at DESC") 
  erb :url_index
end

get '/url' do
  erb :create_url
end

post '/url' do
  if session[:user_id].nil?
    @long_url = params[:long_url]
    @object = Url.new(:original_url => @long_url)
    if @object.save
      redirect '/'
    else
      redirect not_found
    end
  else
    @long_url = params[:long_url]
    @object = Url.new(:original_url => @long_url, :user_id => session[:user_id])
    if @object.save
      redirect '/secrete_page'
    else
      redirect not_found
    end
  end
end

get '/url/:key' do
  @url_key = params[:key]
  @url_object = Url.find_by_key(@url_key)
  @url_object.count += 1
  @url_object.save
  redirect "http://#{@url_object.original_url}"
end

not_found do
  "URL is not valid or Status 404"
end