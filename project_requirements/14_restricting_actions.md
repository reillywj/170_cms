# Restricting Actions to Only Signed-in Users

## Requirements

1. When a signed-out user attempts to perform the following actions, they should be redirected back to the index and shown a message that says 'You must be signed in to do that'
  - Visit the edit page for a document
  - Submit changes to a document
  - Visit the new document page
  - Submit the new document form

## My Implementation Steps

1. Update tests to ensure signed in to do certain things
2. Ensure redirected and message shown for the actions listed


## Differences to Solution
- Had different naming conventions: must_be_signed_in versus require_signed_in_user
  - Otherwise setup was the same
