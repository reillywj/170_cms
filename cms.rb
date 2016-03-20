require 'sinatra'
require 'sinatra/reloader'
require 'erubis'

get '/' do
  @files = Dir.glob("data/*.txt").map {|path| File.basename(path)}
  erb :index
end