# Deleting Documents

## Requirements

1. When a user views the index page, they should see a 'delete' button next to each document
2. When a user clicks a 'delete' button, the application should delete the appropriate document and display a message: '$FILENAME was deleted.'

## My Implementation Steps

1. Add link `<a href="/:filename/delete">Delete</a>` after the edit link
2. Create a POST /:filename/delete route
3. Make sure message is posted stating file was indeed deleted.

## Differences to Solution

1. Test was spot on.
2. Solution adds a form button instead of a simple a-tag/element. I will be switching to this implementation method.
3. Need CSS to put form inline.
