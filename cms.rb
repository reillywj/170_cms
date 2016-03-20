require 'sinatra'
require 'sinatra/reloader'
require 'erubis'

get '/' do
  @files = Dir.glob("data/*.txt").map {|file| file.split('/')[1]}
  erb :index
end