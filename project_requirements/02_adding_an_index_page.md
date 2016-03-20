# Adding an Index Page

## Requirements

Instead of database system, we will have a filesystem instead. This is the path we will follow with this project. Each document help within the CMS will have a name that includes an extension. This extension will determine how the contents of the page are displayed in later steps.

1. When a user visits the home page, they should see a list of the documents in the CMS: `history.txt`, `changes.txt`, and `about.txt`

## My Implementation Steps

1. Create the 3 text files in a /data directory: history, changes, and about
2. Create a /views/layouts.erb file
  - Simple html setup for now
  - Include a yield block for view template
  - Create a /views/index.erb file
3. In cms.rb, under GET '/':
  - create a @files variable
  - erb :index, layout: :layout to show :index

## My Notes on Implementation

1. Nothing too out of the ordinary.

## Additional Steps that LaunchSchool steps Implemented

1. Mostly spot on. I didn't state that I'd use the File class to get a list of documents. I used Dir.glob, but didn't like that implementation. Will refactor.

## Differences to Solution

