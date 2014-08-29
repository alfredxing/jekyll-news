require 'sinatra'
require 'data_mapper'
require 'json'

# Classes
Dir["lib/*.rb"].each { |file| require_relative file }
DataMapper.finalize

# Helpers
Dir["helpers/*.rb"].each { |file| require_relative file }
helpers Auth

# Configuration
require_relative "config/application.rb"

# Controllers
Dir["controllers/*.rb"].each { |file| require_relative file }
