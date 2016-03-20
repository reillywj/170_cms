# Adding Tests

## Requirements

1. Write tests for the routes that the application already supports. Run them and you should see something similar to image.

## My Implementation Steps

1. Add test directory
2. Add cms_test.rb file
3. Add structure for Sinatra Rack testing
4. Add tests for index and plain-text file content
5. Run tests and make sure they pass.

## My Notes on Implementation

1. Interesting to find out that assert_includes creates two assertions, one to make sure that the thing being tested responds to :include? method and a second to see if the object is included in the Collection

## Additional Steps that LaunchSchool steps Implemented

1. Add `minitest` to `Gemfile`; `bundle install`

## Differences to Solution

