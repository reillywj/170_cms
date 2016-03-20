require 'sinatra'
require 'sinatra/reloader'
require 'erubis'

get '/' do
  @files = Dir.glob("data/*.txt").map {|path| File.basename(path)}
  erb :index
end

get "/*.txt" do
  file = params['splat'].first + ".txt"
  
  headers['Content-Type'] = 'text/plain'
  File.read("data/#{file}")
end