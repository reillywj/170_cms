# Viewing Markdown Files

## Requirements

1. When a user views a document written in Markdown format, the browser should render the rendered HTML version of the document's content.

## My Implementation Steps

1. Add some markdown files to the `data/` directory
2. Use Redcarpet to render the text

## My Notes on Implementation

None.

## Additional Steps that LaunchSchool steps Implemented

Implementation steps were essentially the same.

## Differences to Solution

I have two different route handlers, one for .txt and one for .md files. I also created a helper method that yields a block I want to be rendered since everything else was similar between the two except this allows for different behavior based on the file extension. This helper still lets you see what rendering method is being applied to the type of file without having to search for the helper method.

I did refactor to move the markdown's rendering into a separate method, but currently as it's only one place of implementation, I probably didn't need to move this to a method quite yet, but it simplifies some of the code and makes it clearer with what's going on in the route handler.
