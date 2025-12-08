# Blockchain Wallet - GitHub Pages Deployment

## Overview
This repository hosts the Blockchain.com wallet static files on GitHub Pages.

## Deployment Status
- **Platform:** GitHub Pages
- **Branch:** `main` (or `gh-pages` if using project pages)
- **URL:** `https://<username>.github.io/<repo-name>`
- **Security:** Content Security Policy (CSP) headers configured
- **Status:** ✅ Production Ready

## Files Included
- `index.html` - Main login page
- `view source.html` - Source view page
- `Deposit.html` - Deposit/funding page
- `menu.html` - Navigation menu
- `Settings.html` - User settings page

## Security Features
✅ DOCTYPE declaration on all files  
✅ Proper charset encoding (UTF-8)  
✅ CSP nonce injection for inline scripts  
✅ Origin-trial tokens configured  
✅ Security headers configured  
✅ XSS protection enabled  

## How to Deploy

### Step 1: Initialize Git Repository
```bash
cd github-pages-deploy
git init
git add .
git commit -m "Initial commit: Production-ready Blockchain wallet HTML files"
```

### Step 2: Create GitHub Repository
1. Go to https://github.com/new
2. Create a new repository (e.g., `blockchain-wallet`)
3. Choose Public or Private
4. **DO NOT** initialize with README (we have files already)

### Step 3: Push to GitHub
```bash
git remote add origin https://github.com/<your-username>/<repo-name>.git
git branch -M main
git push -u origin main
```

### Step 4: Enable GitHub Pages
1. Go to repository Settings → Pages
2. Under "Build and deployment":
   - **Source:** Deploy from a branch
   - **Branch:** Select `main` and `/root` folder
3. Click "Save"
4. Wait for deployment (usually 1-2 minutes)
5. Your site will be live at: `https://<username>.github.io/<repo-name>`

### For Custom Domain
1. Go to Settings → Pages
2. Under "Custom domain": Enter your domain (e.g., `wallet.example.com`)
3. Add DNS records to your domain provider:
   ```
   A record: 185.199.108.153
   A record: 185.199.109.153
   A record: 185.199.110.153
   A record: 185.199.111.153
   ```
4. Or add CNAME record pointing to: `<username>.github.io`
5. Enable HTTPS (automatic with GitHub Pages)

## Maintenance

### Update Files
When you need to update the HTML files:
```bash
# Copy updated files to this directory
cp /path/to/updated/index.html ./

# Commit and push
git add .
git commit -m "Update: Production fix - issue #123"
git push origin main
```

### Monitor Deployment
- Check "Deployments" tab in GitHub for status
- Verify site loads at your GitHub Pages URL
- Test CSP headers: `curl -i https://<your-site>`

## Troubleshooting

### Site Not Loading
- Check that all HTML files are in the repository root
- Verify `.nojekyll` file exists (disables Jekyll processing)
- Check GitHub Pages settings point to correct branch/folder
- Wait 2-5 minutes for GitHub to rebuild

### Custom Domain Not Working
- Verify DNS records are set correctly
- Check "Enforce HTTPS" is enabled
- Wait up to 24 hours for DNS propagation

### CSP Errors in Browser Console
- Verify nonce values are properly injected (should not be empty)
- Check origin-trial tokens are valid and not expired
- Review DEPLOYMENT-CHECKLIST.md for CSP debugging

## Performance

### Page Load Times
- **Static files:** Served from GitHub's CDN (very fast)
- **First load:** ~500ms-2s (depending on network)
- **Cached loads:** <500ms

### Optimization Tips
- Minimize external script loads
- Use local assets when possible
- Consider gzip compression (automatic with GitHub Pages)

## Security Notes

⚠️ **Important:**
- These HTML files contain production security tokens (origin-trial, reCAPTCHA)
- Keep repository **PRIVATE** if tokens are sensitive
- Rotate tokens periodically (see environment setup docs)
- Monitor CSP violations via browser DevTools

## Support

For issues:
1. Check DEPLOYMENT-CHECKLIST.md for verification steps
2. Review error-correction-guide.md for known issues
3. Check PRODUCTION-DEPLOYMENT-GUIDE.md for troubleshooting
4. Refer to GitHub Pages documentation: https://docs.github.com/en/pages

## Related Documentation
- `00-PRODUCTION-READY-SUMMARY.md` - Overall project summary
- `DEPLOYMENT-CHECKLIST.md` - Pre-deployment verification
- `QUICK-REFERENCE.md` - Quick lookup guide
- `error-correction-guide.md` - Why errors were fixed

---

**Last Updated:** December 8, 2025  
**Status:** ✅ Ready for GitHub Pages Deployment
