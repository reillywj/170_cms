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

def data_path
  if ENV['RACK_ENV'] == 'test'
    File.expand_path('../test/data', __FILE__)
  else
    File.expand_path('../data', __FILE__)
  end
end

def file_basename(extension)
  params['splat'].first + extension
end

def render_markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render text
end

def render_content(file_path)
  if File.file? file_path
    yield(file_path) if block_given?
  else
    session[:message] = "#{File.basename file_path} does not exist."
    redirect '/'
  end
end

def file_exists?(file_basename)
  all_documents.include? file_basename
end

def invalid_filename
  @file = params[:filename]

  @file.empty?
end

def all_documents
  pattern = File.join(data_path, '*')
  @files = Dir.glob(pattern).map { |path| File.basename(path) }
end

def valid_admin_credentials?(username, password)
  username == 'username' && password == 'secret'
end

def admin?
  session[:signedin] == 'admin'
end

def must_be_signed_in
  unless admin?
    session[:message] = 'You must be signed in to do that.'
    redirect '/'
  end
end

get '/' do
  all_documents
  erb :index
end

get '/signin' do
  if session[:signedin]
    redirect '/'
  else
    erb :signin
  end
end

post '/signin' do
  @username = params[:username]
  password = params[:password]
  if valid_admin_credentials?(@username, password)
    session[:signedin] = 'admin'
    session[:message] = 'Welcome!'
    redirect '/'
  else
    session[:message] = 'Invalid Credentials.'
    status 401
    erb :signin
  end
end

get '/signout' do
  session.delete :signedin
  session[:message] = 'You have been signed out.'
  redirect '/'
end

get '/*.txt' do
  file_path = File.join(data_path, params['splat'].first + '.txt')

  render_content(file_path) do |fp|
    headers['Content-Type'] = 'text/plain'
    File.read(fp)
  end
end

get '/*.md' do
  file_path = File.join(data_path, params['splat'].first + '.md')

  render_content(file_path) do |fp|
    render_markdown File.read(fp)
  end
end

get '/:filename/edit' do
  must_be_signed_in

  @file = params[:filename]
  file_path = File.join(data_path, @file)

  render_content(file_path) do |fp|
    @content = File.read(fp)
    erb :edit
  end
end

get '/new' do
  must_be_signed_in

  erb :new
end

post '/new' do
  must_be_signed_in

  @file = params[:filename]
  if @file.empty?
    session[:message] = 'A name is required.'
    status 422
    erb :new
  else
    file_path = File.join(data_path, @file)
    File.new(file_path, 'a+')
    session[:message] = "#{@file} was created."
    redirect '/'
  end
end

post '/:filename' do
  must_be_signed_in

  @file = params[:filename]
  file_path = File.join(data_path, @file)
  @content = params[:content]

  File.write(file_path, @content)
  session[:message] = "#{@file} was updated."
  redirect '/'
end

post '/:filename/delete' do
  must_be_signed_in
  
  file = params[:filename]
  file_path = File.join(data_path, file)
  File.delete(file_path)
  session[:message] = "#{file} was deleted."
  redirect '/'
end
