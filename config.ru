require 'rack'
require 'rack/unreloader'
require 'thin'
require 'json'
require 'pry'

Dir['config/**/*.rb'].each { |f| require "./#{f}" }
Dir['app/**/*.rb'].each { |f| require "./#{f}" }

require './app'

Unreloader = Rack::Unreloader.new { App.new }

Unreloader.require './app.rb'

Dir['app/**/*.rb'].each { |f| Unreloader.require "./#{f}" }

Rack::Handler::Thin.run Unreloader
