get '/' do
  @posts = Post.all(:limit => 30, :order => [ :karma.desc ]).sort_by { |post| post.score }.reverse
  layout :'post/posts'
end

get '/new' do
  @posts = Post.all(:limit => 30).sort_by { |post| post.time }.reverse
  layout :'post/posts'
end

get '/submit' do
  if session[:id].nil?
    redirect '/auth/redirect/submit'
  end
  @title = "New post"
  layout :'post/new'
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
  layout :'post/view'
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
  redirect '/'
end

post '/upvote/:id' do
  post = Post.get(params[:id])
  if !post
    halt 404
  end
  post.upvote(session[:id])
  ""
end
