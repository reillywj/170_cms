# Signing In and Out

## Requirements

1. When a signed-out user views the index page of the site, they should see a "Sign In" button.
2. When a user clicks the "Sign In" button, they should be taken to a new page with a sign in form. The form should contain a text input labeled "Username" and a password input labeled "Password." The form should also contain a submit button labeled "Sign In."
3. When a user enters the username "admin" and password "secret" into the sign in form and clicks the "Sign In" button, they should be signed in and redirected to the index page. A message should display that says "Welcome!"
4. When a user enters any other username and password into the sign in form and clicks the "Sign In" button, the sign in form should be redisplayed and an error message "Invalid Credentials" should be shown. The username they entered into the form should appear in the username input.
5. When a signed-in user views the index page, they should see a message at the bottom of the page that says "Signed in as $USERNAME" followed by a button labeled "Sign Out"
6. When a signed-in user clicks this "Sign Out" button, they should be signed out of the application and redirected to the index page of the site. They should see a message that says "You have been signed out."

## My Implementation Steps

1. Place form with button on index page
  - Link to GET '/signin'
  - Toggle with session[:signedin] value to SignOut if signed in
2. Create SignIn Page
  - Form with username and password and sign in button
  - Submit to POST '/signin'
  - Check for validity
    - If Valid (username = "username"; password = "secret")
      - create session message
      - set session[:signedin] = true
      - redirect to root
    - If not:
      - store username as @username for reuse in the form
      - Create a message
      - show :signin page

## Additional Steps that LaunchSchool steps Implemented

1. 

## Differences to Solution

