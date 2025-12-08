# GitHub Pages Deployment Guide

## Quick Start (5 minutes)

### Prerequisites
- GitHub account (free at github.com)
- Git installed on your computer
- The 5 HTML files (index.html, view source.html, Deposit.html, menu.html, Settings.html)

### Step-by-Step Setup

#### 1. Open PowerShell Terminal
```powershell
cd "C:\Users\User\OneDrive\Documents\Visual Studio 2022\pls don't delete\github-pages-deploy"
```

#### 2. Initialize Git Repository
```powershell
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

#### 3. Add All Files
```powershell
git add .
git status  # Verify files are staged
```

#### 4. Create Initial Commit
```powershell
git commit -m "Initial commit: Blockchain wallet production files with CSP security"
```

#### 5. Create GitHub Repository
1. Go to https://github.com/new
2. Enter repository name: `blockchain-wallet` (or your choice)
3. Add description: "Production Blockchain.com wallet with CSP security"
4. Choose **Public** (required for free GitHub Pages)
5. **UNCHECK** "Initialize this repository with a README"
6. Click "Create repository"

#### 6. Connect and Push to GitHub
```powershell
# Copy the commands from GitHub (they'll look like this):
git remote add origin https://github.com/YOUR-USERNAME/blockchain-wallet.git
git branch -M main
git push -u origin main

# When prompted: Enter GitHub username and password (or personal access token)
```

#### 7. Enable GitHub Pages
1. Go to your repository on GitHub
2. Click **Settings** → **Pages** (left sidebar)
3. Under "Build and deployment":
   - **Source:** Select "Deploy from a branch"
   - **Branch:** Select `main` and `/root` folder
4. Click **Save**

#### 8. Verify Deployment
```powershell
# Wait 1-2 minutes, then check the deployment status
# You should see: "Your site is live at https://YOUR-USERNAME.github.io/blockchain-wallet"
```

**That's it! Your site is now live.** 🎉

---

## Full Deployment Instructions

### Option 1: Using Git Command Line (Recommended)

#### Install Git (if needed)
- Download from https://git-scm.com
- Run installer with default options
- Restart PowerShell

#### Configure Git
```powershell
git config --global user.name "Your Full Name"
git config --global user.email "your.email@example.com"
git config --global core.autocrlf true
```

#### Clone and Setup (Alternative Method)
```powershell
# Create new directory
New-Item -ItemType Directory -Path "C:\Repos\blockchain-wallet" -Force
Set-Location "C:\Repos\blockchain-wallet"

# Copy HTML files from the original location
Copy-Item "C:\Users\User\OneDrive\Documents\Visual Studio 2022\pls don't delete\*.html" .

# Initialize git
git init
git add .
git commit -m "Initial: Production Blockchain wallet files"
```

#### Push to GitHub
```powershell
git remote add origin https://github.com/USERNAME/blockchain-wallet.git
git branch -M main
git push -u origin main

# First push will ask for authentication:
# - Username: Your GitHub username
# - Password: Your GitHub personal access token (not password)
#   Generate at: https://github.com/settings/tokens
```

### Option 2: Using GitHub Desktop (Easier for Beginners)

1. Download from https://desktop.github.com
2. Sign in with GitHub account
3. Click "Create a New Repository"
4. Name: `blockchain-wallet`
5. Local Path: Choose folder with HTML files
6. Click "Create Repository"
7. Make initial commit: "Initial: Production files"
8. Click "Publish repository" (blue button)
9. Make it **Public** (for free GitHub Pages)
10. Click "Publish Repository"

### Option 3: Direct Upload (No Git)

1. Create repository at https://github.com/new
2. Click "Add file" → "Upload files"
3. Drag & drop all HTML files
4. Commit message: "Add production HTML files"
5. Click "Commit changes"

---

## Enable GitHub Pages

### Via GitHub Web Interface

1. Go to: https://github.com/YOUR-USERNAME/blockchain-wallet/settings/pages
2. Under "Build and deployment":
   - **Source:** `Deploy from a branch`
   - **Branch:** `main` / `(root)` folder
   - Click **Save**

3. Wait 2-3 minutes for deployment
4. You'll see: "Your site is live at https://YOUR-USERNAME.github.io/blockchain-wallet"
5. Click the link to verify it's live!

### Verify Deployment
```powershell
# Check site is live
Invoke-WebRequest -Uri "https://YOUR-USERNAME.github.io/blockchain-wallet/" -UseBasicParsing | Select-Object StatusCode, StatusDescription

# Should output:
# StatusCode        : 200
# StatusDescription : OK
```

---

## Custom Domain Setup (Optional)

### If You Have a Custom Domain

#### Add CNAME Record with Your Domain Provider

1. Log in to your domain registrar (GoDaddy, Namecheap, AWS Route 53, etc.)
2. Find DNS/Domain Settings
3. Add a **CNAME record**:
   - **Name/Host:** `wallet` (or whatever subdomain you want)
   - **Value/Points to:** `YOUR-USERNAME.github.io`
   - **TTL:** 3600 (or default)
4. Save changes

#### Alternative: A Records (if CNAME not available)
Add four **A records**:
```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

#### Configure in GitHub
1. Go to repository Settings → Pages
2. Under "Custom domain": Enter `wallet.example.com`
3. Click **Save**
4. Enable **Enforce HTTPS** (will appear after a moment)

**Wait 24 hours for DNS to propagate.**

---

## Updating Files

### When You Need to Update HTML Files

```powershell
# Option 1: Using Git
cd C:\Users\User\OneDrive\Documents\Visual Studio 2022\pls don't delete\github-pages-deploy
cp C:\path\to\updated\index.html .\index.html
git add index.html
git commit -m "Update: Fixed CSP nonce values"
git push origin main

# Option 2: Using GitHub Web UI
# - Go to file on GitHub
# - Click pencil icon to edit
# - Make changes
# - Commit directly to main branch
```

### Monitoring Deployment
1. Go to repository → "Actions" tab
2. See deployment status
3. Wait for green checkmark ✅
4. Site updates automatically (usually within 30 seconds)

---

## Testing Your Deployment

### Quick Verification
```powershell
# Test site loads
$response = Invoke-WebRequest -Uri "https://YOUR-USERNAME.github.io/blockchain-wallet/index.html"
Write-Host "Status: $($response.StatusCode)"
Write-Host "Title: $($response.Content | Select-String '<title>.*</title>' -o | ForEach-Object { $_.Matches[0].Value })"
```

### Browser Testing
1. Go to `https://YOUR-USERNAME.github.io/blockchain-wallet/`
2. Open DevTools (F12)
3. Check Console for any CSP errors
4. Check Network tab for 200 responses
5. Verify CSP header is present:
   ```powershell
   curl -i https://YOUR-USERNAME.github.io/blockchain-wallet/index.html | Select-String -Pattern "content-security-policy" -Context 1,5
   ```

### CSP Validation
```powershell
# Check for CSP header
Invoke-WebRequest -Uri "https://YOUR-USERNAME.github.io/blockchain-wallet/index.html" -UseBasicParsing | ForEach-Object {
    $_.Headers.Keys | Where-Object { $_ -like "*security*" } | ForEach-Object {
        Write-Host "$_`: $($_.Headers[$_])"
    }
}
```

---

## Troubleshooting

### "Page Not Found" Error
**Problem:** Getting 404 when visiting the site
**Solution:**
1. Verify branch is `main` in Settings → Pages
2. Verify files are in repository root (not in subfolder)
3. Check `.nojekyll` file exists
4. Wait 5 minutes and refresh

### "Site not ready yet"
**Problem:** See message "Your site is building..."
**Solution:**
1. This is normal for first deployment
2. Wait 2-5 minutes
3. Check "Actions" tab for build status
4. Refresh page

### Custom Domain Not Working
**Problem:** Custom domain shows GitHub Pages default page
**Solution:**
1. Verify DNS records are set (wait up to 24 hours)
2. In GitHub: Settings → Pages → Check custom domain shows correctly
3. Ensure "Enforce HTTPS" is checked
4. Try clearing browser cache (Ctrl+Shift+Delete)

### CSP Errors in Console
**Problem:** Browser console shows CSP violations
**Solution:**
1. Verify nonce values are not empty
2. Check origin-trial tokens haven't expired
3. Ensure all script tags have `nonce="..."` attribute
4. Review PRODUCTION-DEPLOYMENT-GUIDE.md CSP section

### Files Not Updating
**Problem:** Changes to files don't show on live site
**Solution:**
1. Verify push was successful: `git log -1`
2. Check "Actions" tab shows green checkmark
3. Clear browser cache (Ctrl+F5)
4. Check correct branch is deployed (Settings → Pages)
5. Wait 30 seconds to 2 minutes

---

## GitHub Pages Limits & Quotas

| Feature | Limit |
|---------|-------|
| Repository Size | 1 GB |
| Site Size | 100 GB |
| Bandwidth | Soft limit ~100 GB/month |
| Build Time | 10 minutes |
| Builds per Hour | Unlimited |
| Simultaneous Builds | 1 per user |

Your static HTML files are well under all limits. ✅

---

## Security Notes

⚠️ **Important:** These HTML files contain production security tokens:
- reCAPTCHA Enterprise keys
- Google Pay origin-trial tokens
- CSP nonce values

If these are sensitive:
1. Keep repository **PRIVATE**
2. Rotate tokens regularly
3. Use .gitignore for secrets
4. Never commit real API keys to public repos

---

## Next Steps

1. ✅ Deploy to GitHub Pages (this guide)
2. Monitor site for CSP errors (see DEPLOYMENT-CHECKLIST.md)
3. Set up custom domain (optional, this guide)
4. Enable GitHub Actions for auto-deployments (optional)
5. Monitor performance and uptime

---

## Reference Links

- GitHub Pages Docs: https://docs.github.com/en/pages
- GitHub Pages Limits: https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages
- Custom Domains: https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site
- GitHub Actions: https://docs.github.com/en/actions

---

**Last Updated:** December 8, 2025  
**Status:** ✅ Ready for Deployment
