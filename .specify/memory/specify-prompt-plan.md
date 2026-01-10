# Gist Review - Specify Prompt Plan

This document outlines the sequence of prompts for the [Spec Kit Specify](https://github.com/spec-kit/specify) workflow to incrementally build the Gist Review application. Each prompt results in a testable increment of the software.

## Overview

Based on the [constitution](../.specify/memory/constitution.md), Gist Review is a static, client-side application for reviewing Markdown documents stored in GitHub Gists with contextual, text-anchored comments.

---

## Prompt Sequence

### 1. Static Site Foundation

**Prompt:**
> Create a static HTML page that serves as the Gist Review application shell. It should have a minimal layout with a header, main content area, and basic CSS styling. The page should be deployable to GitHub Pages with no build toolchain and testable locally using a simple HTTP server.

**Testable Outcome:**

- [ ] `index.html` renders in browser
- [ ] Page serves correctly via `python -m http.server` or `npx serve`
- [ ] Page is deployable to GitHub Pages
- [ ] No build step required

---

### 2. URL Parameter Routing

**Prompt:**
> Implement client-side URL parameter parsing to extract the `gist` parameter from URLs in the format `?gist={gist_id}`. Accept both full Gist URLs (e.g., `https://gist.github.com/user/abc123`) and bare Gist IDs. Display the extracted Gist ID on the page.

**Testable Outcome:**

- [ ] `?gist=abc123` displays "abc123" on page
- [ ] `?gist=https://gist.github.com/user/abc123` extracts and displays "abc123"
- [ ] Missing parameter shows helpful message

---

### 3. Fetch and Display Public Gist

**Prompt:**
> Implement fetching a public Gist from the GitHub API using the extracted Gist ID. Display the raw Markdown content of the first file in the Gist. Handle API errors gracefully with user-friendly messages.

**Testable Outcome:**

- [ ] Public Gist content displays as raw text
- [ ] Invalid Gist ID shows error message
- [ ] Network failures show recovery options

---

### 4. Markdown Rendering with Sanitization

**Prompt:**
> Render the fetched Gist Markdown as formatted HTML using a client-side Markdown library. Sanitize rendered content using DOMPurify to prevent XSS attacks. Preserve code blocks and standard Markdown formatting.

**Testable Outcome:**

- [ ] Markdown headings, lists, code blocks render correctly
- [ ] Script tags in Markdown are sanitized/removed
- [ ] Malicious HTML is neutralized

---

### 5. Gist Revision Selector

**Prompt:**
> Fetch and display the revision history of a Gist. Add a UI control (dropdown or list) to select a specific revision. When a revision is selected, display the Gist content at that revision.

**Testable Outcome:**

- [ ] Revision list populates from API
- [ ] Selecting a revision updates displayed content
- [ ] Current revision is visually indicated

---

### 6. GitHub OAuth Authentication

**Prompt:**
> Implement GitHub OAuth authentication using the Device Flow (or a minimal OAuth proxy). Request only the `gist` scope. Store the access token in localStorage. Show login/logout state in the UI header. Document any localhost-specific OAuth configuration needed for local development.

**Testable Outcome:**

- [ ] User can authenticate with GitHub
- [ ] Token stored in localStorage
- [ ] Only `gist` scope is requested
- [ ] Login state persists across page refresh
- [ ] OAuth works from localhost for local development
- [ ] README documents localhost OAuth setup (if applicable)

---

### 7. Fetch and Display Gist Comments

**Prompt:**
> Fetch comments for the current Gist using the GitHub API (authenticated for private gists). Display comments in a sidebar or panel. Parse any YAML/JSON front matter from comment bodies to extract review metadata.

**Testable Outcome:**

- [ ] Comments display for public Gist (unauthenticated)
- [ ] Comments display for private Gist (authenticated)
- [ ] Front matter metadata is parsed and accessible

---

### 8. Text Selection Capture

**Prompt:**
> Implement text selection tracking in the rendered Markdown content. When the user selects text, capture: line number, selection start offset, selection end offset, and selected text. Display the captured selection data in a temporary UI element.

**Testable Outcome:**

- [ ] Selecting text shows selection metadata
- [ ] Line number is accurately captured
- [ ] Character offsets are correct

---

### 9. Create Anchored Comment

**Prompt:**
> Enable authenticated users to create a new Gist comment anchored to the current text selection. Embed the selection metadata (line, offsets, selected text, Gist revision) as YAML front matter in the comment body. Submit using the GitHub API.

**Testable Outcome:**

- [ ] Comment created via GitHub API
- [ ] Comment body includes valid front matter
- [ ] Comment appears in GitHub Gist UI
- [ ] Unauthenticated users see "login to comment" prompt

---

### 10. Visual Comment Anchoring

**Prompt:**
> Highlight text regions in the rendered Markdown that have associated comments. Filter displayed highlights to show only comments matching the currently selected Gist revision. Clicking a highlight should scroll to/focus the related comment.

**Testable Outcome:**

- [ ] Anchored text is visually highlighted
- [ ] Only current-revision comments show highlights
- [ ] Switching revisions updates highlights
- [ ] Click highlight → comment focused

---

### 11. Comment Thread Display

**Prompt:**
> When a text highlight is clicked, show the associated comment(s) in a focused view. If multiple comments anchor to the same or overlapping selections, group them visually as a thread.

**Testable Outcome:**

- [ ] Clicking highlight opens comment detail
- [ ] Overlapping anchors show grouped comments
- [ ] Comment author and timestamp displayed

---

### 12. Multi-File Gist Support

**Prompt:**
> Support Gists containing multiple files. Add a file selector UI to switch between files. Maintain separate comment anchoring per file. Preserve file selection in URL if possible.

**Testable Outcome:**

- [ ] Multi-file Gist shows file tabs/selector
- [ ] Switching files updates content and comments
- [ ] Comments anchor to correct file

---

### 13. Rate Limit Handling

**Prompt:**
> Implement GitHub API rate limit awareness. Display remaining rate limit to users. When rate limited, show clear messaging with reset time and suggest authentication if unauthenticated.

**Testable Outcome:**

- [ ] Rate limit headers are parsed
- [ ] Rate limit status visible in UI
- [ ] 403 rate limit response shows friendly message with retry time

---

### 14. Accessibility Enhancements

**Prompt:**
> Ensure full keyboard navigation for all UI elements: comment sidebar, revision selector, file selector, and text highlights. Add appropriate ARIA labels and support screen reader announcements for dynamic content.

**Testable Outcome:**

- [ ] All interactive elements keyboard accessible
- [ ] Screen reader announces content changes
- [ ] Focus management is logical

---

### 15. Progressive Enhancement & SEO

**Prompt:**
> Ensure the page displays meaningful content (title, description) without JavaScript for SEO purposes. Add appropriate meta tags and Open Graph tags for link previews when sharing Gist Review URLs.

**Testable Outcome:**

- [ ] Page has semantic HTML structure
- [ ] Meta/OG tags populate from Gist metadata
- [ ] Link previews work in Slack/Twitter/etc.

---

### 16. GitHub Pages Deployment

**Prompt:**
> Configure GitHub Pages deployment for the repository. Set up the repository to serve the static site from the appropriate branch. Add any necessary deployment documentation to the README.

**Testable Outcome:**

- [ ] GitHub Pages is enabled in repository settings
- [ ] Site is accessible at `https://{owner}.github.io/gist-review/`
- [ ] URL parameter routing works with GitHub Pages base path
- [ ] README includes deployment instructions

---

## Summary

| # | Increment | Key Principle |
| --- | ----------- | --------------- |
| 1 | Static site foundation | Zero Backend |
| 2 | URL parameter routing | Shareable by Default |
| 3 | Fetch public Gist | GitHub-Native |
| 4 | Markdown rendering | Markdown-First, Security |
| 5 | Revision selector | Markdown-First |
| 6 | GitHub OAuth | GitHub-Native, Security |
| 7 | Display comments | GitHub-Native |
| 8 | Text selection capture | Contextual Anchoring |
| 9 | Create anchored comment | Contextual Anchoring |
| 10 | Visual anchoring | Contextual Anchoring |
| 11 | Comment threads | Contextual Anchoring |
| 12 | Multi-file support | Markdown-First |
| 13 | Rate limit handling | Development Standards |
| 14 | Accessibility | Development Standards |
| 15 | Progressive enhancement | Development Standards |
| 16 | GitHub Pages deployment | Deployment Requirements |
