ruby '2.1.2'
source 'https://rubygems.org'

gem 'sinatra'
gem 'sinatra-flash'

gem 'json'
gem 'rest-client'

gem 'datamapper'
group :development, :test do
  gem 'dm-sqlite-adapter'
  gem 'sqlite3'
end
group :production do
  gem 'dm-postgres-adapter'
  gem 'pg'
end

gem 'unicorn'
