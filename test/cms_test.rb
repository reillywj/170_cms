ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'fileutils'
require_relative '../cms'

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    FileUtils.mkdir_p(data_path)
    users = { 'username' => BCrypt::Password.create('secret') }
    FileUtils.touch('test/users.yml')
    File.open('test/users.yml', 'w') { |f| f.write users.to_yaml }
  end

  def teardown
    FileUtils.rm_rf(data_path)
    FileUtils.rm('test/users.yml')
  end

  def create_document(name, content = '')
    File.open(File.join(data_path, name), 'w') do |file|
      file.write(content)
    end
  end

  def session
    last_request.env['rack.session']
  end

  def must_be_signed_in
    'You must be signed in to do that.'
  end

  def admin_session
    { 'rack.session' => { username: 'admin'} }
  end

  def sign_in
    post '/signin', 'username' => 'username', 'password' => 'secret'
  end

  def test_index
    create_document 'about.md'
    create_document 'changes.txt'

    get '/'
    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, 'changes.txt'
    assert_includes last_response.body, 'about.md'
    assert_includes last_response.body, 'Edit'
    assert_includes last_response.body, 'Delete'
    assert_includes last_response.body, 'New Document'
    assert_includes last_response.body, 'Sign In'
  end

  def test_file
    document_content = "# Title\n\nSomething else here."
    create_document 'about.txt', document_content
    get '/about.txt'
    assert_equal 200, last_response.status
    assert_equal 'text/plain', last_response['Content-Type']
    assert_equal document_content, last_response.body
  end

  def nonexistent_tests(&http_request)
    http_request.call

    error_message = 'nonexistent.txt does not exist.'
    assert_equal 302, last_response.status
    assert_equal error_message, session[:message]

    follow_redirect!
    assert_equal 200, last_response.status
    assert_includes last_response.body, error_message

    get '/'
    refute_includes last_response.body, error_message
  end

  def test_nonexistent_document
    nonexistent_tests { get '/nonexistent.txt' }
  end

  def test_nonexistent_document_edit
    sign_in

    nonexistent_tests { get '/nonexistent.txt/edit' }
  end

  def test_markdown_file
    create_document 'about.md', '## Ruby'
    get '/about.md'
    assert_equal 200, last_response.status
    assert_includes last_response['Content-Type'], 'text/html'
    assert_includes last_response.body, '<h2>Ruby</h2>'
  end

  def test_edit_file
    sign_in

    create_document 'history.md', '# History'

    new_content = "# History\n\nReplaced text."
    status_update = 'history.md was updated.'

    get '/history.md/edit'
    assert_equal 200, last_response.status
    assert_includes last_response.body, '<form action'
    assert_includes last_response.body, '<textarea'
    assert_includes last_response.body, 'Edit content of history.md:'
    assert_includes last_response.body, '# History'
    assert_includes last_response.body, 'Save Changes'

    post '/history.md', 'content' => new_content
    assert_equal 302, last_response.status
    assert_equal status_update, session[:message]

    follow_redirect!
    assert_includes last_response.body, status_update

    get '/'
    refute_includes last_response.body, status_update

    get '/history.md'
    assert_includes last_response.body, 'Replaced text.'
  end

  def test_new
    sign_in

    filename = 'about.txt'

    get '/new'
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Add a new document:'
    assert_includes last_response.body, 'Create Document'
    assert_includes last_response.body, '</form>'

    post '/new', 'filename' => filename
    assert_equal 302, last_response.status
    assert_equal "#{filename} was created.", session[:message]

    follow_redirect!
    assert_equal 200, last_response.status
    assert_includes last_response.body, "#{filename} was created."

    get '/'
    refute_includes last_response.body, "#{filename} was updated."
    assert_includes last_response.body, filename
  end

  def test_invalid_new
    sign_in

    post '/new', 'filename' => ''
    assert_equal 422, last_response.status
    assert_includes last_response.body, 'A name is required.'
  end

  def test_delete_document
    sign_in

    filename = 'about.txt'
    create_document filename, 'Some Content'

    get '/'
    assert_includes last_response.body, filename

    post "/#{filename}/delete", 'filename' => filename
    assert_equal 302, last_response.status
    assert_equal "#{filename} was deleted.", session[:message]

    follow_redirect!
    assert_equal 200, last_response.status
    assert_includes last_response.body, "#{filename} was deleted."

    get '/'
    refute_includes last_response.body, filename
  end

  def test_sigin_and_signout
    get '/signin'
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Username:'
    assert_includes last_response.body, 'Password:'

    sign_in
    assert_equal 302, last_response.status
    assert_equal 'Welcome!', session[:message]

    follow_redirect!
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Welcome!'
    assert_includes last_response.body, 'Signed in as admin.'
    assert_includes last_response.body, 'Sign Out'
    refute_includes last_response.body, 'Sign In'
    assert_equal 'username', session[:signedin]

    get '/'
    refute_includes last_response.body, 'Welcome!'

    get '/signout'
    assert_equal 302, last_response.status
    assert_equal 'You have been signed out.', session[:message]
    follow_redirect!
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Sign In'
    refute_includes last_response.body, 'Sign Out'
    assert_includes last_response.body, 'You have been signed out.'
    assert_equal nil, session[:signedin]
  end

  def test_invalid_credentials
    invalid_name = 'invalid1234'
    post '/signin', 'username' => invalid_name, 'password' => 'secret'
    assert_equal 401, last_response.status
    assert_includes last_response.body, 'Invalid Credentials.'
    assert_includes last_response.body, invalid_name
    assert_equal nil, session[:signedin]
  end

  def restricted_with_document(&http_request)
    filename = 'about.txt'
    create_document filename, 'Some Content'

    http_request.call
    assert_equal must_be_signed_in, session[:message]
    assert_equal  302, last_response.status

    follow_redirect!
    assert_includes last_response.body, must_be_signed_in
  end

  def test_restricted_edit_document
    restricted_with_document do
      get "/about.txt/edit"
    end
  end

  def test_restricted_submit_changes_to_document
    restricted_with_document do
      post "/about.txt", 'content' => 'Some new content.'
    end
  end

  def test_restricted_new_document
    restricted_with_document do
      get '/new'
    end
  end

  def test_restricted_submit_new_document
    restricted_with_document do
      post '/new', 'filename' => 'history.txt'
    end
  end
end

























