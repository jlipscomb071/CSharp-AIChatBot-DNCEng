# Script converts markdown documentation to pdfs 

$markdownDir = "./data/Documentation"


$pdfDir = "./data/Documentation/PDFs"


if (!(Test-Path $pdfDir)) {
    New-Item -ItemType Directory -Path $pdfDir | Out-Null
}


Get-ChildItem $markdownDir -Recurse -Filter "*.md" | ForEach-Object {
    $pdfPath = Join-Path $pdfDir $_.Name.Replace(".md", ".pdf")
    pandoc $_.FullName -o $pdfPath --pdf-engine=xelatex
}


dotnet run --project "app/prepdocs/PrepareDocs/PrepareDocs.csproj" -- `
    "$pdfDir/*.pdf" `
    --storageendpoint $env:AZURE_STORAGE_BLOB_ENDPOINT `
    --container $env:AZURE_STORAGE_CONTAINER `
    --searchendpoint $env:AZURE_SEARCH_SERVICE_ENDPOINT `
    --searchindex $env:AZURE_SEARCH_INDEX `
    --formrecognizerendpoint $env:AZURE_FORMRECOGNIZER_SERVICE_ENDPOINT `
    --tenantid $env:AZURE_TENANT_ID `
    -v


azd env set AZD_PREPDOCS_RAN "true"