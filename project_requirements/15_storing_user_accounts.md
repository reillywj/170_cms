# Storing User Accounts in an External File

## Requirements

1. An administrator should be able to modify the list of users who may sign into the application by editing a configuration file.

## LS Implementation Steps for Help

1. Create users.yml file
2. When a user is attempting to sign in, load the file created in 1 and use it to validate the user's credentials
3. Modify the application to user test/users.yml to load user credentials during testing


## Differences to Solution

