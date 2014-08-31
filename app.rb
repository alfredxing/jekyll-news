require 'sinatra'
require 'data_mapper'
require 'json'
require 'date'
require 'sanitize'

# Classes
Dir["lib/*.rb"].each { |file| require_relative file }
DataMapper.finalize

# Helpers
Dir["helpers/*.rb"].each { |file| require_relative file }
helpers Auth

# Configuration
require_relative "config/application.rb"
DataMapper.auto_upgrade!

# Controllers
Dir["controllers/*.rb"].each { |file| require_relative file }
