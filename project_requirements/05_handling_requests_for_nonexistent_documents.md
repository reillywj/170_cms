# Handling Requests for Nonexistent Documents

## Requirements

1. When a user attempts to view a document that does not exist, they should be redirected to the index page and shown the message: `$DOCUMENT does not exist.`
2. When the user reloads the index page after seeing an error message, the message should go away.

## My Implementation Steps

1. Catch when the file does not exist
  - Create proper error message with sessions[:error]
  - Redirect to index ('/')
  - Clear sessions[:error] with #delete method
2. Add tests (do this first)

## My Notes on Implementation

1. 

## Additional Steps that LaunchSchool steps Implemented

1. 

## Differences to Solution

