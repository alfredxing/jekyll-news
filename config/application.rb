configure do
  # Create db folder if it doesn't exist
  unless File.directory?("db/")
    FileUtils.mkdir_p("db/")
  end

  # Set up database
  configure :development do
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/development.db")
  end
  configure :production do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
  end

	# Enable sessions
	set :sessions, true
  set :session_secret, 'FaLphnSoEtd4AizcOgDb8Y7JCBfGljNuK0T1ek2swQ6mMvq5H9W3PxrRXUyIVZ'
end

# Method condition
set(:method) do |method|
  method = method.to_s.upcase
  condition { request.request_method == method }
end

# Basic routes
before :method => :post do
  content_type :json
end

not_found do
  status 404
  erb :'status/404'
end
