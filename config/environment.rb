# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'twitter'
require 'byebug'

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')


$client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "PodcJN1E3TPhwAW2WKoLnNCRk"
  config.consumer_secret     = "fx9vCd7euyF92yDfnKM3E9aYftoplXDpveqS5IqwcQ9biIJ4V4"
  config.access_token        = "50880114-PaXaCJSShJVSX6FggpsnDjZgxE1AOoZGntNlqNNnj"
  config.access_token_secret = "jtKZerucnt7SruYWFsrM0Ka6mYuifbmAVY3GFux0l79wU"
end