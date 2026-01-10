# Research: Progressive Enhancement & SEO

**Feature**: 15-progressive-enhancement-seo  
**Date**: 2026-01-10

## Research Tasks

### 1. Open Graph Tags

**Decision**: Include standard Open Graph meta tags.

**Required Tags**:
```html
<meta property="og:title" content="Gist Review">
<meta property="og:description" content="Review and comment on GitHub Gists with anchored feedback">
<meta property="og:type" content="website">
<meta property="og:url" content="https://username.github.io/gist-review/">
<meta property="og:image" content="https://username.github.io/gist-review/og-image.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
```

### 2. Twitter Card Tags

**Decision**: Use summary card type.

**Tags**:
```html
<meta name="twitter:card" content="summary">
<meta name="twitter:title" content="Gist Review">
<meta name="twitter:description" content="Review and comment on GitHub Gists with anchored feedback">
<meta name="twitter:image" content="https://username.github.io/gist-review/og-image.png">
```

### 3. SEO Meta Tags

**Decision**: Include standard SEO meta tags.

**Tags**:
```html
<meta name="description" content="Review and comment on GitHub Gists with anchored feedback. A static web app for collaborative Markdown review.">
<meta name="keywords" content="gist, github, review, comments, markdown, code review">
<meta name="author" content="Gist Review">
<link rel="canonical" href="https://username.github.io/gist-review/">
```

### 4. Noscript Fallback Content

**Decision**: Provide full fallback with logo, features, and GitHub link.

**HTML**:
```html
<noscript>
  <div class="noscript-fallback">
    <img src="logo.png" alt="Gist Review Logo" width="64" height="64">
    <h1>Gist Review</h1>
    <p>A collaborative review tool for GitHub Gists</p>
    <h2>Features</h2>
    <ul>
      <li>View public GitHub Gists with Markdown rendering</li>
      <li>Browse revision history</li>
      <li>Add anchored comments to specific text</li>
      <li>Collaborate with context-aware feedback</li>
    </ul>
    <p><strong>JavaScript Required:</strong> Gist Review requires JavaScript for full functionality. Please enable JavaScript to view and comment on Gists.</p>
    <p><a href="https://github.com/username/gist-review">View on GitHub</a></p>
  </div>
</noscript>
```

### 5. Semantic HTML Structure

**Decision**: Use HTML5 semantic elements.

**Structure**:
```html
<body>
  <header role="banner">
    <h1>Gist Review</h1>
    <nav aria-label="Main navigation">...</nav>
  </header>
  <main id="main-content" role="main">
    <article>...</article>
    <aside role="complementary">...</aside>
  </main>
  <footer role="contentinfo">...</footer>
</body>
```

### 6. Open Graph Image

**Decision**: Create 1200x630px branded image.

**Requirements**:
- Size: 1200x630 pixels (Facebook/LinkedIn recommended)
- Format: PNG or JPG
- Content: App logo, name "Gist Review", brief tagline
- Background: Solid brand color

### 7. CSS Fallback

**Decision**: Ensure content readable if CSS fails.

**Approach**:
- Use semantic HTML that flows naturally
- Avoid layout entirely dependent on CSS
- Test with CSS disabled

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| OG Tags | title, description, image, url | Social sharing |
| Twitter | summary card | Compact preview |
| SEO | description, keywords, canonical | Search visibility |
| Noscript | Full fallback with features | Graceful degradation |
| Structure | Semantic HTML5 | SEO and accessibility |
| OG Image | 1200x630 branded | Platform standards |
| CSS Fallback | Semantic structure | Resilience |
