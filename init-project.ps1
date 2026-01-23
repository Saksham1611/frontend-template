# Frontend Template Initialization Script for Windows
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$ProjectName
)

$ErrorActionPreference = "Stop"

Write-Host "`n🚀 Frontend Template Initialization" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

$ProjectNameUnderscore = $ProjectName -replace '-', '_'
Write-Host "📦 Project name: $ProjectName" -ForegroundColor Yellow

# Check for node
Write-Host "`n🔍 Checking prerequisites..." -ForegroundColor Yellow
try {
    $null = Get-Command node -ErrorAction Stop
    $nodeVersion = node -v
    Write-Host "✓ Node.js found ($nodeVersion)" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js is required but not installed." -ForegroundColor Red
    Write-Host "Please install Node.js (v20+) from: https://nodejs.org/"
    exit 1
}

# Check for pre-commit
$hasPrecommit = $true
try {
    $null = Get-Command pre-commit -ErrorAction Stop
    Write-Host "✓ pre-commit found" -ForegroundColor Green
} catch {
    Write-Host "⚠️ pre-commit not found. Initial setup will skip git hook installation." -ForegroundColor Yellow
    $hasPrecommit = $false
}

# Replace placeholders
Write-Host "`n📝 Replacing placeholders..." -ForegroundColor Yellow
$Placeholder = "bootstrap-project-frontend"

if (Test-Path "package.json") {
    $content = Get-Content "package.json" -Raw
    $content = $content -replace $Placeholder, $ProjectName
    Set-Content "package.json" $content -NoNewline
    Write-Host "  ✓ package.json"
}

if (Test-Path "index.html") {
    $content = Get-Content "index.html" -Raw
    $content = $content -replace $Placeholder, $ProjectName
    Set-Content "index.html" $content -NoNewline
    Write-Host "  ✓ index.html"
}

if (Test-Path ".github\workflows\docker-build.yml") {
    $content = Get-Content ".github\workflows\docker-build.yml" -Raw
    $content = $content -replace '{{project_name}}', $ProjectNameUnderscore
    Set-Content ".github\workflows\docker-build.yml" $content -NoNewline
    Write-Host "  ✓ docker-build.yml"
}

# Reinitialize git
if (Test-Path ".git") {
    Write-Host "`n🔄 Reinitializing git repository..." -ForegroundColor Yellow
    Remove-Item ".git" -Recurse -Force
    git init
    Write-Host "✓ Fresh git repository created" -ForegroundColor Green
}

# Install pre-commit hooks
if ($hasPrecommit) {
    Write-Host "`n🪝 Installing pre-commit hooks..." -ForegroundColor Yellow
    pre-commit install
    Write-Host "✓ Pre-commit hooks installed" -ForegroundColor Green
}

# Install dependencies
Write-Host "`n📦 Installing dependencies..." -ForegroundColor Yellow
npm install
Write-Host "✓ Dependencies installed" -ForegroundColor Green

# Success
Write-Host ""
Write-Host "✅ Project '$ProjectName' initialized successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Start the development server:"
Write-Host "     npm run dev"
Write-Host ""
Write-Host "  2. Make your first commit:"
Write-Host "     git add ."
Write-Host "     git commit -m 'Initial commit'"
Write-Host ""
