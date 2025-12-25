# PowerShell script to push GitHub Pages to GitHub
# This script handles the repository creation and push process

param(
    [Parameter(Mandatory=$false)]
    [string]$RepoName = "blockchain-wallet",
    
    [Parameter(Mandatory=$false)]
    [string]$RepoDescription = "Production Blockchain wallet with CSP security",
    
    [Parameter(Mandatory=$false)]
    [string]$GitHubUsername = $null,
    
    [switch]$Public,
    [switch]$Help
)

if ($Help) {
    Write-Host @"
GitHub Repo Push Helper

Usage: .\push-to-github.ps1 [options]

Options:
  -RepoName           Name for the repository (default: blockchain-wallet)
  -RepoDescription    Repository description (default: Production Blockchain...)
  -GitHubUsername     Your GitHub username (will be prompted if not provided)
  -Public             Make repository public (default: prompted)
  -Help               Show this help message

Examples:
  .\push-to-github.ps1
  .\push-to-github.ps1 -RepoName my-wallet -GitHubUsername myusername -Public
"@
    exit 0
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "GitHub Repository Push Helper" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Get GitHub username if not provided
if (-not $GitHubUsername) {
    $GitHubUsername = Read-Host "Enter your GitHub username"
    if ([string]::IsNullOrWhiteSpace($GitHubUsername)) {
        Write-Host "Error: GitHub username is required" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Repository Details:" -ForegroundColor Yellow
Write-Host "  Repository name: $RepoName"
Write-Host "  Description: $RepoDescription"
Write-Host "  Owner: $GitHubUsername"
Write-Host ""

# Display instructions
Write-Host "STEP 1: Create Repository on GitHub" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Go to: https://github.com/new" -ForegroundColor Cyan
Write-Host ""
Write-Host "Enter these settings:" -ForegroundColor Yellow
Write-Host "  Repository name: $RepoName"
Write-Host "  Description: $RepoDescription"
Write-Host "  Visibility: Public" -ForegroundColor Yellow
Write-Host "  UNCHECK: Initialize with README" -ForegroundColor Yellow
Write-Host ""
Write-Host "Click: Create repository" -ForegroundColor Yellow
Write-Host ""

[void](Read-Host "Press Enter after creating the repository on GitHub")

Write-Host ""
Write-Host "STEP 2: Configure Local Git & Push" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Configure git if not already done
Write-Host "Configuring git..." -ForegroundColor Yellow
$currentUser = git config --global user.name
$currentEmail = git config --global user.email

if (-not $currentUser) {
    $name = Read-Host "Enter your full name"
    git config --global user.name "$name"
    Write-Host "✓ Git user configured" -ForegroundColor Green
}

if (-not $currentEmail) {
    $email = Read-Host "Enter your email"
    git config --global user.email "$email"
    Write-Host "✓ Git email configured" -ForegroundColor Green
}

Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
Write-Host ""

# Add remote
Write-Host "Adding remote origin..." -ForegroundColor Cyan
git remote add origin "https://github.com/$GitHubUsername/$RepoName.git" 2>$null
if ($LASTEXITCODE -eq 128) {
    Write-Host "Remote already exists, updating..." -ForegroundColor Yellow
    git remote set-url origin "https://github.com/$GitHubUsername/$RepoName.git"
}

# Rename branch to main if needed
Write-Host "Ensuring branch is 'main'..." -ForegroundColor Cyan
git branch -M main

# Push to GitHub
Write-Host "Pushing code to GitHub..." -ForegroundColor Cyan
Write-Host "(You may be prompted for credentials)" -ForegroundColor Yellow
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✓ Successfully pushed to GitHub!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "STEP 3: Enable GitHub Pages" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Go to: https://github.com/$GitHubUsername/$RepoName/settings/pages" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Configure:" -ForegroundColor Yellow
    Write-Host "  Source: Deploy from a branch"
    Write-Host "  Branch: main"
    Write-Host "  Folder: / (root)"
    Write-Host ""
    Write-Host "Click: Save" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Your site will be live at:" -ForegroundColor Green
    Write-Host "  https://$GitHubUsername.github.io/$RepoName/" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Wait 1-2 minutes for GitHub Pages to build..." -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "Error: Failed to push to GitHub" -ForegroundColor Red
    Write-Host "Please check your credentials and try again" -ForegroundColor Yellow
    Write-Host ""
}

Write-Host "Done!" -ForegroundColor Green
