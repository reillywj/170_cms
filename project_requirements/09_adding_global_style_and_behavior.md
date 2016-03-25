# Adding Global Style and Behavior

## Requirements

1. When a message is displayed to a user, that message should appear against a yellow background.
2. Messages should disappear if the page they appear on is reloaded
3. Text files should continue to be displayed by the browser as plain text
4. The entire site (including markdown files, but not text files) should be displayed in a sans-serif typefact.

## My Implementation Steps

1. Add yellow background coloring to the display message (note: convert all messages to generic :message in sessions instead of :error and :success)
2. Disappear on reload already accomplished
3. Text files shouldn't be hampered by any changes here.
4. Set typeface to sans-serif with some styling.

## Additional Steps that LaunchSchool steps Implemented

1. More specifics:
  - I created main.css under a public/stylesheets directory instead of a cms.css under a public directory

## Differences to Solution
- I had already accommodated for the differences between .md and .txt presentation
- I had not added padding; to be consistent I added in the padding.
- I removed the tabular format to be consistent with the LS solution.
