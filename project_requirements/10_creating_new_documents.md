# Creating New Documents

## Requirements

1. When a user views the index page, they should see a link that says 'New Document'
2. When a user clicks the 'New Document' link, they should be taken to a page with a text input labeled 'New document name' and a submit button labeled 'Create Document'
3. When a user enters a page name and clicks 'Create Document', they should be redirected to the index page. The name they entered in the form should now appear in the file list. They should see a message that says '$FILENAME has been created'
4. If a user attempts to create a new document without a name, the form should be redisplayed and a message should say 'A name is required.'

## My Implementation Steps

1. Create tests:
  - Add test to index test to check New Document link is there
  - Test for '/new' page
    - Verify 200 request
    - Verify text on page
  - Test for valid POST '/' page
    - test valid submission of new file to create
  - Test for empty POST to '/new' page
    - reload '/new' page, with message at top
    - message should disappear on reload
  - Test for file already exists
    - file should not be overridden (check text content not blank)
    - reload '/new' page with filename typed in value
    - message should appear at top
    - on reload, message should disappear
2. Make sure tests fail
3. Make tests pass
  - 'New Document' link to '/new'
  - Add new.erb to views
  - create GET request for '/new'
  - create POST '/new' to post creation of a new document
  - Include validation of sorts for empty filename and same filename


## My Notes on Implementation

1. I had initially included a validation to check if file already exists. I removed to align with the LS solution.

## Differences to Solution

1. I did not know about status 422. So I added status 422 upon empty new file submission. Otherwise I covered everything else.

