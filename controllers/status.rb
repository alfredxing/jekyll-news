get '/status' do
  User.all.inspect + "\n" + session[:id].inspect
end
