# Viewing Text Files

## Requirements

1. When a user visits the index page, they are presented with a list of links, one for each document in the CMS
2. When a user clicks on a document link in the index, they should be taken to a page that displays the content of the file whose name was clicked
3. When a user visits the path `/history.txt`, they will be presented with the content of the document `history.txt'
4. The browser should render a text file as a plain text file.

## My Implementation Steps

1. Add links to pages to view the content of the files
2. Create a view for viewing content
3. Show content of file. Store content in a @content variable
4. Render as plain text file (don't do anything with markup)

## My Notes on Implementation

1. Was able to implement most except for plain/text. I had to defer to solutions as I couldn't find anything in my search as I looked for HTML solutions instead of a Sinatra solution.
2. Ended up not needing a content view, this was removed.

## Additional Steps that LaunchSchool steps Implemented

## Differences to Solution
1. Still using `root`. Not sure if needed yet or not.
