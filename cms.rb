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

def render_markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render text
end

def render_content(extension)
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
  render_content('.txt') do |file|
    headers['Content-Type'] = 'text/plain'
    File.read("data/#{file}")
  end
end

get '/*.md' do
  render_content('.md') do |file|
    render_markdown File.read("data/#{file}")
  end
end

get '/*/edit' do
  @file = params['splat'].first
  @content = File.read("data/#{@file}")
  erb :edit
end

post '/*' do
  @file = params['splat'].first
  @content = params['content']
  File.write("data/#{@file}", @content)
  session[:success] = "#{@file} was updated."
  redirect '/'
end


















