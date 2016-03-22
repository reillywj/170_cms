# Editing Document Content

## Requirements

1. When a user views the index page, ,they should see an 'Edit' link next to each document name.
2. When a user clicks an edit link, they should be taken to an edit page for the appropriate document.
3. When a user views the edit page for a document, that document's content should appear within a textarea.
4. When a user edits the document's content and clicks a 'Save Changes' button, they are redirected to the index page and are shown a message; `$FILENAME was updated.`.

## My Implementation Steps

1. Add Edit link next to file
  - Switch formatted from an unordered list to a tabular format
2. Create /:filename/edit route
  - Create an edit.erb file in views/
  - Add ERB/HTML
    - Heading: `Edit content of $FILENAME:`
    - Form:
      - Text area: set size so that it's a percentage of the window's width and height
      - Submit button: `Save Changes`
3. Form should POST to a /:filename route
  - Save the file
  - Set `session[:success] = "$FILENAME was updated."`
  - Redirect to index page


## My Notes on Implementation

1. I wasn't sure whether to use an unordered list or a table, so I show both options for now.
2. 

## Additional Steps that LaunchSchool steps Implemented

1. 

## Differences to Solution

