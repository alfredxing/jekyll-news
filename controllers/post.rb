get '/' do
  @posts = Post.all(:order => [ :karma.desc ])
  erb :'post/top', :layout => :'layouts/default'
end

get '/' do
  @posts = Post.all(:order => [ :karma.desc ])
  erb :'post/top', :layout => :'layouts/default'
end

get '/submit' do
  @title = "New post"
  erb :'post/new', :layout => :'layouts/default'
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
    :author => session[:id],
    :time   => Time.new.to_date
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
