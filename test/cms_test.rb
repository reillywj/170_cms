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
  end

  def teardown
    FileUtils.rm_rf(data_path)
  end

  def create_document(name, content = "")
    File.open(File.join(data_path, name), "w") do |file|
      file.write(content)
    end
  end

  def test_index
    create_document 'about.md'
    create_document 'changes.txt'

    get '/'
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, 'changes.txt'
    assert_includes last_response.body, 'about.md'
    assert_includes last_response.body, 'Edit'
    assert_includes last_response.body, 'New Document'
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
    nonexistent_tests {get '/nonexistent.txt/edit'}
  end

  def test_markdown_file
    create_document 'about.md', "## Ruby"
    get '/about.md'
    assert_equal 200, last_response.status
    assert_includes last_response['Content-Type'], 'text/html'
    assert_includes last_response.body, '<h2>Ruby</h2>'
  end

  def test_edit_file
    create_document 'history.md', '# History'

    new_content = "# History\n\nReplaced text."
    status_update = 'history.md was updated'

    get '/history.md/edit'
    assert_equal 200, last_response.status
    assert_includes last_response.body, '<form action'
    assert_includes last_response.body, '<textarea'
    assert_includes last_response.body, 'Edit content of history.md:'
    assert_includes last_response.body, "# History"
    assert_includes last_response.body, 'Save Changes'

    post '/history.md', params={'content' => new_content}
    assert_equal 302, last_response.status

    follow_redirect!
    assert_includes last_response.body, status_update

    get '/'
    refute_includes last_response.body, status_update

    get '/history.md'
    assert_includes last_response.body, 'Replaced text.'
  end

  def test_new
    get '/new'
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Add a new document:'
    assert_includes last_response.body, 'Create Document'
    assert_includes last_response.body, '</form>'
  end
end