get '/' do
  Post.all.inspect
end

get '/new' do
  erb :'post/new'
end

get '/post/:id' do
  post = Post.get(params[:id])
  if !post
    halt 404
  end
  @title = post.title
  @author = User.get(post.author).name
  @link = post.link
  @text = post.text
end

post '/post/new' do
  args = {
    :title  => params[:title],
    :link   => params[:link],
    :text   => params[:text],
    :author => session[:id]
  }
  post = Post.create(args)
  post.save
end

post '/post/:id/upvote' do
  post = Post.get(params[:id])
  if !post
    halt 404
  end
end
