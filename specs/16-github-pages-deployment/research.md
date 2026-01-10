# Research: GitHub Pages Deployment

**Feature**: 16-github-pages-deployment  
**Date**: 2026-01-10

## Research Tasks

### 1. GitHub Actions Workflow for Pages

**Decision**: Use official `actions/deploy-pages` action.

**Workflow**:
```yaml
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
        
      - name: Build (copy files)
        run: |
          mkdir -p _site
          cp -r *.html *.css *.js *.png 404.html _site/ 2>/dev/null || true
          
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

### 2. 404.html for SPA Routing

**Decision**: Create redirect page that preserves query parameters.

**HTML**:
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Gist Review</title>
  <script>
    // Redirect to index.html preserving query params
    var path = window.location.pathname;
    var query = window.location.search;
    var hash = window.location.hash;
    window.location.replace('/gist-review/' + query + hash);
  </script>
</head>
<body>
  <p>Redirecting...</p>
</body>
</html>
```

### 3. Repository Settings

**Decision**: Enable GitHub Pages via Actions in repository settings.

**Steps**:
1. Go to Settings → Pages
2. Select "GitHub Actions" as source
3. Workflow will auto-deploy

### 4. Status Badge

**Decision**: Add GitHub Actions badge to README.

**Markdown**:
```markdown
![Deploy to GitHub Pages](https://github.com/username/gist-review/actions/workflows/deploy.yml/badge.svg)
```

### 5. README Documentation

**Decision**: Add deployment section to README.

**Content**:
- Deployment process overview
- How to trigger deployment
- How to verify deployment
- Custom domain instructions (optional)

### 6. Build Step Extensibility

**Decision**: Include simple copy step that can be expanded.

**Rationale**:
- Currently no build needed (vanilla JS)
- Placeholder for future bundler/minifier
- Easy to extend workflow

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| Workflow | actions/deploy-pages | Official, well-supported |
| Source | GitHub Actions | Modern approach |
| 404 | Redirect to index.html | SPA routing |
| Badge | Actions workflow badge | Deployment visibility |
| Docs | README section | Contributor info |
| Build | Simple copy step | Future extensibility |
