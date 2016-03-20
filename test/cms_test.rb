ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require_relative '../cms'

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, 'about.txt'
    assert_includes last_response.body, 'changes.txt'
    assert_includes last_response.body, 'history.txt'
  end

  def test_file
    get '/about.txt'
    assert_equal 200, last_response.status
    assert_equal 'text/plain', last_response['Content-Type']
    assert_includes last_response.body, 'This is a content management system'
  end

  def test_nonexistent_document
    get '/nonexistent.txt'
    error_message = 'nonexistent.txt does not exist.'
    assert_equal 302, last_response.status

    follow_redirect!
    assert_equal 200, last_response.status
    assert_includes last_response.body, error_message

    get '/'
    refute_includes last_response.body, error_message
  end
end