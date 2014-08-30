require 'sinatra/flash'

get '/auth' do
	flash[:state] = state = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten.shuffle[0,32].join
  redirect Auth.oauth_url state
end

get '/auth/redirect/:path' do
  flash[:state] = state = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten.shuffle[0,32].join
  redirect (Auth.oauth_url state) + "&redirect_uri=http://#{request.host}/auth/callback?redirect=#{params[:path]}"
end

get '/auth/callback' do
  if flash[:state] != params[:state] || params[:state].nil?
    halt 401, (erb :'status/401', :locals => { :message => "OAuth state mismatch" })
  end

  begin
    token = Auth.obtain_token params[:code]
  rescue Exception => e
    halt 401, (erb :'status/401', :locals => { :message => e.message })
  end

  client = Client.new(token)
  session[:token] = token
  session[:id] = id = client.user[:id]
  session[:user] = user = client.user[:login]
  session[:avatar] = client.user[:avatar_url]

  if !User.get(id)
    user = User.create(:id => id, :name => user)
    user.save
  end

  if params[:redirect]
    redirect "/#{params[:redirect]}"
  else
    redirect '/'
  end
end
