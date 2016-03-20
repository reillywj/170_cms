# Getting Started

## Requirements

1. When a user visits the '/' path, the application should display the text "Getting started."

## My Implementation Steps

1. Need to setup cms.rb file with Sinatra requirements both within the file and the directories and files required to display this simple text.
2. Add GET '/' {"Getting started." } code to cms.rb file
3. Test setup

## My Notes on Implementation

1. Only needed to add cms.rb file
2. Make sure I have the sinatra gem (`gem list | grep sinatra`; otherwise `gem install sinantra`)
3. Add require 'sinatra' to cms.rb file
4. Add GET '/' {"Getting started."}

## Additional Steps that LaunchSchool steps Implemented

1. Add Gemfile, include dependencies for `sinatra` and `sinatra-contrib`

## Differences to Solution

No major differences. It was good to include a Gemfile and the sintra-contrib gem, then `bundle install` to ensure gems included to run the app.