# Data Model: Progressive Enhancement & SEO

**Feature**: 15-progressive-enhancement-seo  
**Date**: 2026-01-10

## Overview

This feature adds static HTML content and meta tags for SEO and social sharing. No JavaScript state changes required.

## Entities

### MetaTagSet

Collection of meta tags for the page.

| Field | Type | Description |
|-------|------|-------------|
| title | string | Page title |
| description | string | Page description |
| ogTitle | string | Open Graph title |
| ogDescription | string | Open Graph description |
| ogImage | string | Open Graph image URL |
| ogUrl | string | Canonical URL |
| twitterCard | string | Twitter card type |

### NoscriptContent

Static content displayed when JS is disabled.

| Field | Type | Description |
|-------|------|-------------|
| logo | string | Logo image path |
| title | string | App title |
| description | string | App description |
| features | string[] | Feature bullet points |
| jsMessage | string | JavaScript required message |
| repoUrl | string | GitHub repository URL |

## Static Configuration

### Meta Tags (in index.html)

```html
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gist Review - Collaborative Gist Comments</title>
  
  <!-- SEO -->
  <meta name="description" content="Review and comment on GitHub Gists with anchored feedback">
  <link rel="canonical" href="https://username.github.io/gist-review/">
  
  <!-- Open Graph -->
  <meta property="og:title" content="Gist Review">
  <meta property="og:description" content="Review and comment on GitHub Gists with anchored feedback">
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://username.github.io/gist-review/">
  <meta property="og:image" content="https://username.github.io/gist-review/og-image.png">
  
  <!-- Twitter -->
  <meta name="twitter:card" content="summary">
  <meta name="twitter:title" content="Gist Review">
  <meta name="twitter:description" content="Review and comment on GitHub Gists with anchored feedback">
</head>
```

### Semantic Page Structure

```html
<body>
  <a href="#main-content" class="skip-link">Skip to content</a>
  
  <header role="banner">
    <h1>Gist Review</h1>
    <nav aria-label="Main navigation">
      <!-- Navigation items -->
    </nav>
  </header>
  
  <main id="main-content" role="main">
    <noscript>
      <!-- Fallback content -->
    </noscript>
    <article id="gist-content">
      <!-- Dynamic content -->
    </article>
    <aside id="comment-sidebar" role="complementary">
      <!-- Comments -->
    </aside>
  </main>
  
  <footer role="contentinfo">
    <!-- Footer content -->
  </footer>
</body>
```

## Functions

No JavaScript functions needed. This feature is entirely static HTML.

## Assets

### og-image.png

- Dimensions: 1200 x 630 pixels
- Content: Logo + "Gist Review" + tagline
- Format: PNG
- Location: Repository root
