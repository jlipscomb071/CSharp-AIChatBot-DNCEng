# Set the path to the directory containing the Markdown files
$markdownDir = "./data/Documentation"

# Set the path to the directory where the PDF files will be saved
$pdfDir = "./data/Documentation/PDFs"

# Create the PDF directory if it doesn't already exist
if (!(Test-Path $pdfDir)) {
    New-Item -ItemType Directory -Path $pdfDir | Out-Null
}

# Convert each Markdown file to PDF using pandoc with LaTeX
Get-ChildItem $markdownDir -Recurse -Filter "*.md" | ForEach-Object {
    $pdfPath = Join-Path $pdfDir $_.Name.Replace(".md", ".pdf")
    pandoc $_.FullName -o $pdfPath --pdf-engine=xelatex
}

# Pass the PDF files to the "PrepareDocs" application
dotnet run --project "app/prepdocs/PrepareDocs/PrepareDocs.csproj" -- `
    "$pdfDir/*.pdf" `
    --storageendpoint $env:AZURE_STORAGE_BLOB_ENDPOINT `
    --container $env:AZURE_STORAGE_CONTAINER `
    --searchendpoint $env:AZURE_SEARCH_SERVICE_ENDPOINT `
    --searchindex $env:AZURE_SEARCH_INDEX `
    --formrecognizerendpoint $env:AZURE_FORMRECOGNIZER_SERVICE_ENDPOINT `
    --tenantid $env:AZURE_TENANT_ID `
    -v

# Set the AZD_PREPDOCS_RAN environment variable to "true"
azd env set AZD_PREPDOCS_RAN "true"