@echo off
REM GitHub Pages Deployment Script for Windows
REM This script automates the GitHub Pages setup and deployment

setlocal enabledelayedexpansion

echo.
echo ========================================
echo GitHub Pages Deployment Setup
echo ========================================
echo.

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed!
    echo Please install Git from: https://git-scm.com/download/win
    pause
    exit /b 1
)

REM Check if we're in the right directory
if not exist "index.html" (
    echo ERROR: index.html not found!
    echo Please run this script from the github-pages-deploy directory
    pause
    exit /b 1
)

echo Step 1: Checking if repository is initialized...
if not exist ".git" (
    echo Initializing git repository...
    git init
    echo Setting up Git configuration...
    git config user.name "GitHub Pages Deployer"
    git config user.email "deployment@github.local"
) else (
    echo Repository already initialized
)

echo.
echo Step 2: Adding files...
git add .
git status

echo.
echo Step 3: Creating initial commit...
git commit -m "Initial commit: Production-ready Blockchain wallet files with CSP security" --allow-empty

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Create a new repository at: https://github.com/new
echo 2. Name it: blockchain-wallet
echo 3. Choose: Public (for free GitHub Pages)
echo 4. UNCHECK: Initialize with README
echo 5. Click: Create repository
echo.
echo Then copy these commands from GitHub and paste them here:
echo   git remote add origin https://github.com/YOUR-USERNAME/blockchain-wallet.git
echo   git branch -M main
echo   git push -u origin main
echo.
echo.
echo For more detailed instructions, read: GITHUB-PAGES-SETUP.md
echo.
pause
