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
 
### Where's the code?
 - The magic is all in [the Powershell script](run-tests.ps1).

### Future work
 - Take a look at [FSCheck](https://github.com/fscheck/FsCheck/blob/master/src/FsCheck/Runner.fs), it knows how to run a subset of tests
