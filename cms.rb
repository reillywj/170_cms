require 'sinatra'
require 'sinatra/reloader'
require 'erubis'
require 'pry'
configure do
  enable :sessions
  # give 'secret'
  set :session_secret, 'secret'
end

get '/' do
  @files = Dir.glob("data/*.txt").map {|path| File.basename(path)}
  erb :index
end

get "/*.txt" do
  file = params['splat'].first + ".txt"

  if File.file?("data/#{file}")
    headers['Content-Type'] = 'text/plain'
    File.read("data/#{file}")
  else
    status 404
    session[:error] = "#{file} does not exist."
    redirect '/'
  end
end