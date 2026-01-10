---
title: Gist Review - Specify Prompt Plan
context:
  - ./constitution.md
task_count: 16
categories:
  - foundation
  - api
  - ui
  - comments
  - security
  - deployment
---

# Gist Review - Specify Prompt Plan

This document outlines the sequence of prompts for the [Spec Kit Specify](https://github.com/spec-kit/specify) workflow to incrementally build the Gist Review application. Each prompt results in a testable increment of the software.

## Overview

Based on the [constitution](./constitution.md), Gist Review is a static, client-side application for reviewing Markdown documents stored in GitHub Gists with contextual, text-anchored comments.

---

## Task 1: Static Site Foundation

```yaml
id: 1
depends_on: []
status: pending
category: foundation
```

**Prompt:**

Create a static HTML page that serves as the Gist Review application shell. It should have a minimal layout with a header, main content area, and basic CSS styling. The page should be deployable to GitHub Pages with no build toolchain and testable locally using a simple HTTP server.

**Acceptance Criteria:**

- [ ] `index.html` renders in browser
- [ ] Page serves correctly via `python -m http.server` or `npx serve`
- [ ] Page is deployable to GitHub Pages
- [ ] No build step required

---

## Task 2: URL Parameter Routing

```yaml
id: 2
depends_on: [1]
status: pending
category: foundation
```

**Prompt:**

Implement client-side URL parameter parsing to extract the `gist` parameter from URLs in the format `?gist={gist_id}`. Accept both full Gist URLs (e.g., `https://gist.github.com/user/abc123`) and bare Gist IDs. Display the extracted Gist ID on the page.

**Acceptance Criteria:**

- [ ] `?gist=abc123` displays "abc123" on page
- [ ] `?gist=https://gist.github.com/user/abc123` extracts and displays "abc123"
- [ ] Missing parameter shows helpful message

---

## Task 3: Fetch and Display Public Gist

```yaml
id: 3
depends_on: [2]
status: pending
category: api
```

**Prompt:**

Implement fetching a public Gist from the GitHub API using the extracted Gist ID. Display the raw Markdown content of the first file in the Gist. Handle API errors gracefully with user-friendly messages.

**Acceptance Criteria:**

- [ ] Public Gist content displays as raw text
- [ ] Invalid Gist ID shows error message
- [ ] Network failures show recovery options

---

## Task 4: Markdown Rendering with Sanitization

```yaml
id: 4
depends_on: [3]
status: pending
category: [ui, security]
```

**Prompt:**

Render the fetched Gist Markdown as formatted HTML using a client-side Markdown library. Sanitize rendered content using DOMPurify to prevent XSS attacks. Preserve code blocks and standard Markdown formatting.

**Acceptance Criteria:**

- [ ] Markdown headings, lists, code blocks render correctly
- [ ] Script tags in Markdown are sanitized/removed
- [ ] Malicious HTML is neutralized

---

## Task 5: Gist Revision Selector

```yaml
id: 5
depends_on: [3]
status: pending
category: ui
```

**Prompt:**

Fetch and display the revision history of a Gist. Add a UI control (dropdown or list) to select a specific revision. When a revision is selected, display the Gist content at that revision.

**Acceptance Criteria:**

- [ ] Revision list populates from API
- [ ] Selecting a revision updates displayed content
- [ ] Current revision is visually indicated

---

## Task 6: GitHub OAuth Authentication

```yaml
id: 6
depends_on: [1]
status: pending
category: security
```

**Prompt:**

Implement GitHub OAuth authentication using the Device Flow (or a minimal OAuth proxy). Request only the `gist` scope. Store the access token in localStorage. Show login/logout state in the UI header. Document any localhost-specific OAuth configuration needed for local development.

**Acceptance Criteria:**

- [ ] User can authenticate with GitHub
- [ ] Token stored in localStorage
- [ ] Only `gist` scope is requested
- [ ] Login state persists across page refresh
- [ ] OAuth works from localhost for local development
- [ ] README documents localhost OAuth setup (if applicable)

---

## Task 7: Fetch and Display Gist Comments

```yaml
id: 7
depends_on: [3, 6]
status: pending
category: [api, comments]
```

**Prompt:**

Fetch comments for the current Gist using the GitHub API (authenticated for private gists). Display comments in a sidebar or panel. Parse any YAML/JSON front matter from comment bodies to extract review metadata.

**Acceptance Criteria:**

- [ ] Comments display for public Gist (unauthenticated)
- [ ] Comments display for private Gist (authenticated)
- [ ] Front matter metadata is parsed and accessible

---

## Task 8: Text Selection Capture

```yaml
id: 8
depends_on: [4]
status: pending
category: comments
```

**Prompt:**

Implement text selection tracking in the rendered Markdown content. When the user selects text, capture: line number, selection start offset, selection end offset, and selected text. Display the captured selection data in a temporary UI element.

**Acceptance Criteria:**

- [ ] Selecting text shows selection metadata
- [ ] Line number is accurately captured
- [ ] Character offsets are correct

---

## Task 9: Create Anchored Comment

```yaml
id: 9
depends_on: [6, 7, 8]
status: pending
category: comments
```

**Prompt:**

Enable authenticated users to create a new Gist comment anchored to the current text selection. Embed the selection metadata (line, offsets, selected text, Gist revision) as YAML front matter in the comment body. Submit using the GitHub API.

**Acceptance Criteria:**

- [ ] Comment created via GitHub API
- [ ] Comment body includes valid front matter
- [ ] Comment appears in GitHub Gist UI
- [ ] Unauthenticated users see "login to comment" prompt

---

## Task 10: Visual Comment Anchoring

```yaml
id: 10
depends_on: [5, 7, 8]
status: pending
category: [ui, comments]
```

**Prompt:**

Highlight text regions in the rendered Markdown that have associated comments. Filter displayed highlights to show only comments matching the currently selected Gist revision. Clicking a highlight should scroll to/focus the related comment.

**Acceptance Criteria:**

- [ ] Anchored text is visually highlighted
- [ ] Only current-revision comments show highlights
- [ ] Switching revisions updates highlights
- [ ] Click highlight → comment focused

---

## Task 11: Comment Thread Display

```yaml
id: 11
depends_on: [10]
status: pending
category: [ui, comments]
```

**Prompt:**

When a text highlight is clicked, show the associated comment(s) in a focused view. If multiple comments anchor to the same or overlapping selections, group them visually as a thread.

**Acceptance Criteria:**

- [ ] Clicking highlight opens comment detail
- [ ] Overlapping anchors show grouped comments
- [ ] Comment author and timestamp displayed

---

## Task 12: Multi-File Gist Support

```yaml
id: 12
depends_on: [3, 7]
status: pending
category: ui
```

**Prompt:**

Support Gists containing multiple files. Add a file selector UI to switch between files. Maintain separate comment anchoring per file. Preserve file selection in URL if possible.

**Acceptance Criteria:**

- [ ] Multi-file Gist shows file tabs/selector
- [ ] Switching files updates content and comments
- [ ] Comments anchor to correct file

---

## Task 13: Rate Limit Handling

```yaml
id: 13
depends_on: [3]
status: pending
category: api
```

**Prompt:**

Implement GitHub API rate limit awareness. Display remaining rate limit to users. When rate limited, show clear messaging with reset time and suggest authentication if unauthenticated.

**Acceptance Criteria:**

- [ ] Rate limit headers are parsed
- [ ] Rate limit status visible in UI
- [ ] 403 rate limit response shows friendly message with retry time

---

## Task 14: Accessibility Enhancements

```yaml
id: 14
depends_on: [5, 7, 10, 12]
status: pending
category: ui
```

**Prompt:**

Ensure full keyboard navigation for all UI elements: comment sidebar, revision selector, file selector, and text highlights. Add appropriate ARIA labels and support screen reader announcements for dynamic content.

**Acceptance Criteria:**

- [ ] All interactive elements keyboard accessible
- [ ] Screen reader announces content changes
- [ ] Focus management is logical

---

## Task 15: Progressive Enhancement & SEO

```yaml
id: 15
depends_on: [4]
status: pending
category: ui
```

**Prompt:**

Ensure the page displays meaningful content (title, description) without JavaScript for SEO purposes. Add appropriate meta tags and Open Graph tags for link previews when sharing Gist Review URLs.

**Acceptance Criteria:**

- [ ] Page has semantic HTML structure
- [ ] Meta/OG tags populate from Gist metadata
- [ ] Link previews work in Slack/Twitter/etc.

---

## Task 16: GitHub Pages Deployment

```yaml
id: 16
depends_on: [1]
status: pending
category: deployment
```

**Prompt:**

Configure GitHub Pages deployment for the repository. Set up the repository to serve the static site from the appropriate branch. Add any necessary deployment documentation to the README.

**Acceptance Criteria:**

- [ ] GitHub Pages is enabled in repository settings
- [ ] Site is accessible at `https://{owner}.github.io/gist-review/`
- [ ] URL parameter routing works with GitHub Pages base path
- [ ] README includes deployment instructions

---

## Summary

| # | Increment | Category | Key Principle |
|---|-----------|----------|---------------|
| 1 | Static site foundation | foundation | Zero Backend |
| 2 | URL parameter routing | foundation | Shareable by Default |
| 3 | Fetch public Gist | api | GitHub-Native |
| 4 | Markdown rendering | ui, security | Markdown-First, Security |
| 5 | Revision selector | ui | Markdown-First |
| 6 | GitHub OAuth | security | GitHub-Native, Security |
| 7 | Display comments | api, comments | GitHub-Native |
| 8 | Text selection capture | comments | Contextual Anchoring |
| 9 | Create anchored comment | comments | Contextual Anchoring |
| 10 | Visual anchoring | ui, comments | Contextual Anchoring |
| 11 | Comment threads | ui, comments | Contextual Anchoring |
| 12 | Multi-file support | ui | Markdown-First |
| 13 | Rate limit handling | api | Development Standards |
| 14 | Accessibility | ui | Development Standards |
| 15 | Progressive enhancement | ui | Development Standards |
| 16 | GitHub Pages deployment | deployment | Deployment Requirements |

## Dependency Graph

```text
Task 1 (foundation)
├── Task 2 → Task 3 → Task 4 → Task 8 ─┐
│              │        └── Task 15    │
│              ├── Task 5 ─────────────┼── Task 10 → Task 11
│              ├── Task 13             │
│              └── Task 12 ────────────┤
├── Task 6 ────────────────────────────┼── Task 7 ─┤
│                                      │           └── Task 9
└── Task 16                            └── Task 14
```
