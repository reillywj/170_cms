# Editing Document Content

## Requirements

1. When a user views the index page, ,they should see an 'Edit' link next to each document name.
2. When a user clicks an edit link, they should be taken to an edit page for the appropriate document.
3. When a user views the edit page for a document, that document's content should appear within a textarea.
4. When a user edits the document's content and clicks a 'Save Changes' button, they are redirected to the index page and are shown a message; `$FILENAME was updated.`.

## My Implementation Steps

1. Add Edit link next to filename in the views/index.erb
  - Switch formatted from an unordered list to a tabular format
2. Create /:filename/edit route
  - Create an edit.erb file in views/
  - Add ERB/HTML
    - Heading: `Edit content of $FILENAME:`
    - Form:
      - Text area: set textarea width and height
      - Submit: `Save Changes`
3. Form should POST to a /:filename route
  - Save the file
  - Set `session[:success] = "$FILENAME was updated."`
  - Redirect to index page


## My Notes on Implementation

1. I wasn't sure whether to use an unordered list or a table, so I show both options for now.


## Additional Steps that LaunchSchool steps Implemented

1. My steps are on par with LS implementation steps. I did edit some wording to enhance the description.

## Differences to Solution

1. My tests covered the same tests the LS solution tested for.
2. My form was "okay" but needed improvement:
  - Needed to put label in a label tag within the form
  - Had used an input tab to create the generic submit button for the form; switched to the button tag.
  -Otherwise:
    - Ended up having same textarea dimensions (20x100)
3. Otherwise, very pleased with my implementation.

Note: I still don't know why there'd be a benefit to have the "root" part of the path in `file_path = root + '/data/' + params[:filename]`; perhaps related to when this gets pushed to Heroku. Until then, leaving as I had coded.
