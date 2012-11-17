# -- coding: utf-8

$:.unshift File.expand_path('..', __FILE__)

require "rubygems"
require "bundler/setup"
Bundler.require

require "active_attr"
require "sinatra/reloader" if development?
require "lib/teamcity"
require "lib/builds"

use Rack::LiveReload

set :api_uri, "http://192.168.24.27:8111/httpAuth/app/rest/"
set :build_types, %w{bt4 bt5}

get "/" do
  erb :index
end

get "/teamcity/builds.html" do
  erb :builds
end

get "/teamcity/builds.json" do
  teamcity = Teamcity::Client.new(settings.api_uri)
  json Builds.new(teamcity).latest
end
