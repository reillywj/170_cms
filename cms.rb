require 'sinatra'
require 'sinatra/reloader'
require 'erubis'
require 'redcarpet'

require 'pry'

configure do
  enable :sessions
  # give 'secret'
  set :session_secret, 'secret'
end

def file_basename(extension)
  params['splat'].first + extension
end

def show_content(extension)
  file = file_basename extension

  if File.file?("data/#{file}")
    yield(file) if block_given?
  else
    session[:error] = "#{file} does not exist."
    redirect '/'
  end
end

get '/' do
  @files = Dir.glob("data/*").map {|path| File.basename(path)}
  erb :index
end

get "/*.txt" do
  show_content('.txt') do |file|
    headers['Content-Type'] = 'text/plain'
    File.read("data/#{file}")
  end
end

get '/*.md' do
  show_content('.md') do |file|
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render File.read("data/#{file}")
  end
end