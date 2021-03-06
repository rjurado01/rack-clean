require 'json'
require 'pry'
require 'rack'
require 'rack/unreloader'
require 'singleton'
require 'sequel'
require 'thin'

require 'dry-types'
require 'dry-struct'
require 'dry-schema'

module Types
  include Dry.Types()
end

Dir['config/**/*.rb'].each { |f| require "./#{f}" }
Dir['app/global/*.rb'].each { |f| require "./#{f}" }
Dir['app/**/*.rb'].each { |f| require "./#{f}" unless f.match?('global') }

require './app'

Unreloader = Rack::Unreloader.new { App.new }

Unreloader.require './app.rb'

Dir['app/**/*.rb'].each { |f| Unreloader.require "./#{f}" }

Rack::Handler::Thin.run Unreloader
