get '/' do
  @posts = Post.all(:limit => 30, :order => [ :karma.desc ]).sort_by { |post| post.score }.reverse
  erb :'post/posts', :layout => :'layouts/default'
end

get '/new' do
  @posts = Post.all(:limit => 30).sort_by { |post| post.time }.reverse
  erb :'post/posts', :layout => :'layouts/default'
end

get '/submit' do
  if session[:id].nil?
    redirect '/auth/redirect/submit'
  end
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
  erb :'post/view', :layout => :'layouts/default'
end

post '/post/new' do
  args = {
    :title  => params[:title],
    :link   => params[:link],
    :text   => params[:text],
    :author => session[:id],
    :time   => Time.new
  }
  post = Post.create(args).process
end

get '/upvote/:id' do
  post = Post.get(params[:id])
  if !post
    halt 404
  end
  post.upvote(session[:id])
  post.votes.inspect
end
