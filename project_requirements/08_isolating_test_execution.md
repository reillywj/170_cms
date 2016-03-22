# Isolating Test Execution

## Requirements

1. Update tests and cms.rb to handle a testing environment.

## My Implementation Steps Based on LS Steps in the Notes

1. Add data_path method to check ENV["RACK_ENV"] == "test" to create the appropriate pathway based on the environment.
2. Update cms.rb to handle two different paths for where the files are located.
  - Note: use `File.join()` to handle different OpSystems path formatting with \ and /
3. Update tests with SEAT thought with setup and teardown methods to:
  - `require 'fileutils'` to handle common shell commands
  - setup: mkdir_p(data_path)
  - teardown: rm_rf(data_path)
  - implement a `create_document` method to handle creating documents faster
    - Update tests; will need to `create_document`s as needed

## Differences to Solution

