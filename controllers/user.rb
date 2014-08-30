get '/user/logout' do
  session.clear
  redirect '/'
end

get '/user/:id' do
  redirect "https://github.com/#{params[:id]}"
end
