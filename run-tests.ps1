dotnet test --logger:"nunit;LogFileName=attempt1.xml"
if ($LASTEXITCODE -eq 0) {
    "Tests passed first time"
    return;
}

$failedTwice = 0
$root = [xml](Get-Content .\TestResults\attempt1.xml)
$root.'test-run'.'test-suite'.'test-suite'.'test-suite'.'test-case' `
| Where-Object { $_.result -eq "Failed" } `
| ForEach-Object {
    $testName = $_.fullname
    $resultFile = $testName -replace '[^a-zA-Z0-9]', '_'
    "Retrying test: $testName"
    dotnet test --filter "FullyQualifiedName=$testName" --logger:"nunit;LogFileName=retry-$resultFile.xml"
    if ($LASTEXITCODE -ne 0) {
        $failedTwice++
    }
}

"Tests failed after retry: $failedTwice"
exit $failedTwice