# Quickstart: GitHub Pages Deployment

**Feature**: 16-github-pages-deployment  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-15
- Repository owner/admin access
- GitHub Actions enabled

## Implementation Steps

1. **Create GitHub Actions workflow**:
   ```yaml
   # .github/workflows/deploy.yml
   name: Deploy to GitHub Pages
   
   on:
     push:
       branches: [main]
     workflow_dispatch:
   
   permissions:
     contents: read
     pages: write
     id-token: write
   
   concurrency:
     group: pages
     cancel-in-progress: false
   
   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         
         - name: Setup Pages
           uses: actions/configure-pages@v5
           
         - name: Build
           run: |
             mkdir -p _site
             cp index.html _site/
             cp styles.css _site/ 2>/dev/null || true
             cp app.js _site/ 2>/dev/null || true
             cp 404.html _site/ 2>/dev/null || true
             cp *.png _site/ 2>/dev/null || true
             
         - name: Upload artifact
           uses: actions/upload-pages-artifact@v3
           with:
             path: _site
   
     deploy:
       environment:
         name: github-pages
         url: ${{ steps.deployment.outputs.page_url }}
       runs-on: ubuntu-latest
       needs: build
       steps:
         - name: Deploy to GitHub Pages
           id: deployment
           uses: actions/deploy-pages@v4
   ```

2. **Create 404.html**:
   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
     <meta charset="UTF-8">
     <meta name="viewport" content="width=device-width, initial-scale=1.0">
     <title>Gist Review</title>
     <script>
       // Preserve query params and redirect to index
       const basePath = '/gist-review/';
       const query = window.location.search;
       const hash = window.location.hash;
       window.location.replace(basePath + query + hash);
     </script>
   </head>
   <body>
     <p>Redirecting to Gist Review...</p>
     <p><a href="/gist-review/">Click here if not redirected</a></p>
   </body>
   </html>
   ```

3. **Configure GitHub Pages**:
   - Go to repository Settings → Pages
   - Set Source: "GitHub Actions"
   - Save

4. **Add status badge to README**:
   ```markdown
   # Gist Review
   
   ![Deploy to GitHub Pages](https://github.com/{owner}/gist-review/actions/workflows/deploy.yml/badge.svg)
   ```

5. **Add deployment documentation to README**:
   ```markdown
   ## Deployment
   
   This application is automatically deployed to GitHub Pages when 
   changes are pushed to the `main` branch.
   
   **Live Site**: https://{owner}.github.io/gist-review/
   
   ### Manual Deployment
   
   1. Go to Actions tab
   2. Select "Deploy to GitHub Pages" workflow
   3. Click "Run workflow"
   
   ### Verify Deployment
   
   1. Check Actions tab for workflow status
   2. Visit the GitHub Pages URL
   3. Test with a Gist parameter: `?gist={gist_id}`
   ```

## Testing

### Workflow Test

1. Push change to main branch
2. Go to Actions tab
3. Verify workflow runs successfully
4. Check deployment job completes

### Site Verification

1. Navigate to GitHub Pages URL
2. Verify page loads correctly
3. Test with Gist parameter
4. Test OAuth flow
5. Test comment creation

### 404 Redirect Test

1. Navigate to invalid path: `/gist-review/invalid`
2. Verify redirect to index.html
3. Verify query params preserved

## Verification Steps

1. Push workflow to repository
2. Enable GitHub Pages in settings
3. Wait for initial deployment
4. Access site at GitHub Pages URL
5. Verify all features work
6. Verify badge shows in README
7. Test 404 redirect works

## Success Criteria Checklist

- [ ] Workflow file in `.github/workflows/`
- [ ] GitHub Pages enabled via Actions
- [ ] Site accessible at GitHub Pages URL
- [ ] Auto-deploys on push to main
- [ ] 404.html handles SPA routing
- [ ] Query params preserved in redirects
- [ ] Status badge in README
- [ ] Deployment docs in README
- [ ] All features work on deployed site
