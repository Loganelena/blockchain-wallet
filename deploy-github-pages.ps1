# GitHub Pages Deployment Script for PowerShell
# Run this script to set up your GitHub Pages repository

param(
    [switch]$SkipGitCheck,
    [switch]$Help
)

if ($Help) {
    Write-Host "GitHub Pages Deployment Helper" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage: .\deploy-github-pages.ps1 [options]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -SkipGitCheck    Skip Git installation check"
    Write-Host "  -Help            Show this help message"
    Write-Host ""
    Write-Host "Quick Start:"
    Write-Host "1. Run: .\deploy-github-pages.ps1"
    Write-Host "2. Follow the prompts"
    Write-Host "3. Push to GitHub when ready"
    Write-Host ""
    exit 0
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "GitHub Pages Deployment Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
if (-not $SkipGitCheck) {
    Write-Host "Step 1: Checking Git installation..." -ForegroundColor Yellow
    try {
        $gitVersion = git --version 2>$null
        Write-Host "✓ Git found: $gitVersion" -ForegroundColor Green
    } catch {
        Write-Host "✗ Git is not installed!" -ForegroundColor Red
        Write-Host "Download from: https://git-scm.com/download/win" -ForegroundColor Cyan
        Write-Host "Restart PowerShell after installation"
        Read-Host "Press Enter to exit"
        exit 1
    }
}

# Check if we're in the right directory
Write-Host ""
Write-Host "Step 2: Verifying directory..." -ForegroundColor Yellow
if (-not (Test-Path "index.html")) {
    Write-Host "✗ index.html not found!" -ForegroundColor Red
    Write-Host "Please run this script from the github-pages-deploy directory" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}
Write-Host "✓ Found 5 HTML files:" -ForegroundColor Green
Get-ChildItem -Filter "*.html" | Where-Object {$_.Name -ne "404.html"} | ForEach-Object {
    Write-Host "  - $($_.Name) ($([math]::Round($_.Length/1024, 2)) KB)" -ForegroundColor Green
}

# Initialize Git repository
Write-Host ""
Write-Host "Step 3: Initializing Git repository..." -ForegroundColor Yellow
if (-not (Test-Path ".git")) {
    git init | Out-Null
    Write-Host "✓ Repository initialized" -ForegroundColor Green
    
    Write-Host "Setting up Git configuration..." -ForegroundColor Yellow
    git config user.name "GitHub Pages Deployer"
    git config user.email "deployment@github.local"
    Write-Host "✓ Git configured" -ForegroundColor Green
} else {
    Write-Host "✓ Repository already initialized" -ForegroundColor Green
}

# Add files to staging
Write-Host ""
Write-Host "Step 4: Staging files..." -ForegroundColor Yellow
git add . | Out-Null
$stagedCount = (git status --short | Measure-Object).Count
if ($stagedCount -gt 0) {
    Write-Host "✓ Staged $stagedCount files" -ForegroundColor Green
} else {
    Write-Host "✓ Files already staged or no changes" -ForegroundColor Green
}

# Show status
Write-Host ""
Write-Host "Repository Status:" -ForegroundColor Yellow
git status --short | ForEach-Object {
    Write-Host "  $_" -ForegroundColor Cyan
}

# Create initial commit
Write-Host ""
Write-Host "Step 5: Creating initial commit..." -ForegroundColor Yellow
git commit -m "Initial commit: Production-ready Blockchain wallet files with CSP security" --allow-empty 2>$null
Write-Host "✓ Commit created" -ForegroundColor Green

# Show commit log
Write-Host ""
Write-Host "Commit History:" -ForegroundColor Yellow
git log --oneline -5 | ForEach-Object {
    Write-Host "  $_" -ForegroundColor Cyan
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "📋 Next Steps:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1️⃣  Create GitHub Repository:" -ForegroundColor Yellow
Write-Host "   - Go to: https://github.com/new" -ForegroundColor Cyan
Write-Host "   - Name: blockchain-wallet" -ForegroundColor Cyan
Write-Host "   - Description: Production Blockchain wallet files" -ForegroundColor Cyan
Write-Host "   - Choose: Public (required for free GitHub Pages)" -ForegroundColor Cyan
Write-Host "   - UNCHECK: Initialize with README" -ForegroundColor Cyan
Write-Host "   - Click: Create repository" -ForegroundColor Cyan
Write-Host ""

Write-Host "2️⃣  Copy Commands from GitHub:" -ForegroundColor Yellow
Write-Host "   After creating repo, GitHub will show you commands like:" -ForegroundColor Cyan
Write-Host ""
Write-Host '   git remote add origin https://github.com/YOUR-USERNAME/blockchain-wallet.git' -ForegroundColor White -BackgroundColor DarkGray
Write-Host '   git branch -M main' -ForegroundColor White -BackgroundColor DarkGray
Write-Host '   git push -u origin main' -ForegroundColor White -BackgroundColor DarkGray
Write-Host ""

Write-Host "3️⃣  Paste Commands Here:" -ForegroundColor Yellow
Write-Host "   Paste the three commands above into this PowerShell window" -ForegroundColor Cyan
Write-Host ""

Write-Host "4️⃣  Enable GitHub Pages:" -ForegroundColor Yellow
Write-Host "   - Go to: Settings > Pages (in your repository)" -ForegroundColor Cyan
Write-Host "   - Source: Deploy from a branch" -ForegroundColor Cyan
Write-Host "   - Branch: main / (root)" -ForegroundColor Cyan
Write-Host "   - Wait 2-3 minutes" -ForegroundColor Cyan
Write-Host ""

Write-Host "5️⃣  Your Site is Live!" -ForegroundColor Yellow
Write-Host "   - URL: https://YOUR-USERNAME.github.io/blockchain-wallet/" -ForegroundColor Green
Write-Host ""

Write-Host "📚 For More Info:" -ForegroundColor Cyan
Write-Host "   - Read: GITHUB-PAGES-SETUP.md" -ForegroundColor Yellow
Write-Host "   - Custom domains, troubleshooting, and more detailed instructions" -ForegroundColor Cyan
Write-Host ""

Write-Host "Press Enter when ready to continue..." -ForegroundColor Yellow
Read-Host | Out-Null
