### What does this repo do?
 - Runs `dotnet test` against a flaky test suite
 - Parses the test results xml file
 - Generates an NUnit where string for any failing test cases
 - Runs `dotnet test` again for each failing test

### What works?
 - Automatically generating a filter by test name
 - Parameterized tests
 - Parameter values including characters `!$%^&*()_+-=`

### What doesn't work?
 - Filter by class name (probably easy)
 - Parameter values including characters `"£` (probably hard)
 
