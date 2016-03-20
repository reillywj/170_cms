# Handling Requests for Nonexistent Documents

## Requirements

1. When a user attempts to view a document that does not exist, they should be redirected to the index page and shown the message: `$DOCUMENT does not exist.`
2. When the user reloads the index page after seeing an error message, the message should go away.

## My Implementation Steps

1. Catch when the file does not exist
  - Create proper error message with session[:error]
  - Redirect to index ('/')
  - Clear session[:error] with #delete method
2. Add tests (do this first)

## My Notes on Implementation

1. used `follow_redirect!` method to continue with redirect

## Additional Steps that LaunchSchool steps Implemented

1. Uses `get last_response['Location']` instead of the `follow_redirect!` method
2. Does not make sure the message goes away for whatever reason.

## Differences to Solution

1. I added the paragraph tags on the message
2. All else looks about the same.
  - Did not need to set status to 404; instead redirect takes care of status; so I removed this
  - I used `File.file?` instead of `File.exist?`. They seem to be about the same except `file?` appears to also make sure the file is a regular file; whatever 'regular' means I'm not sure
