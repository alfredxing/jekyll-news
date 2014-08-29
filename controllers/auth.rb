require 'sinatra/flash'

get '/auth' do
	flash[:state] = state = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten.shuffle[0,32].join
  redirect Auth.oauth_url state
end

get '/auth/callback' do
  if flash[:state] != params[:state] || params[:state].nil?
    halt 401, (erb :'status/401', :locals => { :message => "OAuth state mismatch" })
  end

  begin
    token = Auth.obtain_token params[:code]
  rescue Exception
    halt 401, (erb :'status/401', :locals => { :message => "Unable to obtain token" })
  end

  client = Client.new(token)
  session[:token] = token
  session[:id] = id = client.user[:id]

  if !User.get(id)
    user = User.create(:id => id, :name => client.user[:login])
    user.save
  end

  redirect '/status'
end
