$ErrorActionPreference = "Stop"

dotnet test --logger:"nunit;LogFileName=attempt1.xml" | Out-Null
if ($LASTEXITCODE -eq 0) {
    "Tests passed first time"
    return;
}

$failedTwice = 0
$root = [xml](Get-Content .\TestResults\attempt1.xml)
$root.'test-run'.'test-suite'.'test-suite'.'test-suite'.'test-case' `
| Where-Object { $_.result -eq "Failed" } `
| ForEach-Object {
    # Escape parentheses around test cases
    $testName = $_.fullname -replace '\(', '\(' -replace '\)', '\)'
    $escapedTestName = [uri]::EscapeDataString(($testName -replace '!', '\!'))
    $resultFile = $_.fullname -replace '[^a-zA-Z0-9]', '_'
    "Retrying test $testName with filter $escapedTestName"
    dotnet test --filter "FullyQualifiedName=$escapedTestName" --no-build --logger:"nunit;LogFileName=retry-$resultFile.xml"
    if ($LASTEXITCODE -ne 0) {
        $failedTwice++
    }
    $root = [xml](Get-Content ".\TestResults\retry-$resultFile.xml")
    $testCount = $root.'test-run'.'test-suite'.'test-suite'.'test-suite'.'test-case' `
    | Measure-Object `
    | Select-Object -ExpandProperty Count
    if ($testCount -ne 1) {
        throw "Filter should have matched 1 test ($testName), but matched $testCount tests"
    }
}

"Tests failed after retry: $failedTwice"
exit $failedTwice