<!--
SYNC IMPACT REPORT
==================
Version change: 1.1.0 → 1.2.0 (Local development environment requirement added)
Modified principles: None
Added sections:
  - Local development requirements added to Deployment Requirements
Removed sections: None
Templates requiring updates:
  - plan-template.md ✅ (no updates required - generic template compatible)
  - spec-template.md ✅ (no updates required - generic template compatible)
  - tasks-template.md ✅ (no updates required - generic template compatible)
Follow-up TODOs: None
-->

# Gist Review Constitution

## Core Principles

### I. Markdown-First

All documents under review MUST remain as pure Markdown files stored in GitHub Gists.

- Document content MUST NOT be modified by the review system
- Comments and review metadata MUST be stored separately from document content
- Markdown format ensures optimal LLM consumption and version control compatibility
- Gist revision history serves as the document version control mechanism

**Rationale**: Preserving Markdown as the source of truth enables seamless integration with
LLM workflows, maintains portability, and leverages GitHub's built-in versioning.

### II. Zero Backend

The application MUST operate as a fully static site with no server-side components beyond GitHub's infrastructure.

- All application logic MUST execute client-side in the browser
- Data persistence MUST use GitHub APIs exclusively (Gists, Gist Comments)
- OAuth token exchange MAY use a minimal proxy (Cloudflare Worker, Gatekeeper) or Device Flow
- No custom databases, servers, or stateful backend services are permitted

**Rationale**: Eliminating backend infrastructure reduces operational complexity, hosting costs,
and security surface area while enabling simple GitHub Pages deployment.

### III. GitHub-Native

All authentication, storage, and collaboration features MUST use GitHub's native capabilities.

- Authentication MUST use GitHub OAuth with minimal scope (`gist` only)
- Document storage MUST use GitHub Gists API
- Review comments MUST be stored as Gist comments with embedded metadata
- User identity MUST be derived from GitHub accounts

**Rationale**: GitHub-native integration ensures familiar identity, eliminates account
proliferation, and leverages GitHub's reliability and API ecosystem.

### IV. Shareable by Default

Review sessions MUST be accessible via simple, shareable URLs.

- URLs MUST follow the format: `https://{host}/gist-review?gist={gist_id}`
- Both full Gist URLs and bare Gist IDs MUST be accepted as parameters
- Public Gists MUST be viewable without authentication
- Authentication MUST only be required for creating or modifying comments

**Rationale**: Low-friction sharing encourages adoption and enables quick collaboration
without onboarding overhead.

### V. Contextual Anchoring

Comments MUST be anchored to specific text selections within documents.

- Each comment MUST store: line number, selection start/end offsets, selected text, Gist revision
- Comment metadata MUST be embedded as front matter in Gist comments
- Comments are tied to a specific Gist revision to maintain context over time
- The UI must visually highlight text selections associated with comments
- The UI must show comments only for the specific revision being displayed
- The UI must allow users to select different revisions and view associated comments

**Rationale**: Text-anchored comments provide precise feedback context, similar to Word
or PR reviews, enabling actionable and unambiguous review discussions.

## Security Requirements

All security implementations MUST follow these constraints:

- OAuth tokens MUST be stored in `localStorage` (same-origin protection)
- OAuth scope MUST be limited to `gist` (no repository, issue, or other access)
- Markdown rendering MUST sanitize content using DOMPurify or equivalent
- Content Security Policy headers MUST be configured to prevent XSS
- External images in Markdown SHOULD be proxied or restricted

**Rationale**: Minimal token scope and client-side sanitization limit blast radius of
potential security incidents while enabling necessary functionality.

## Development Standards

All code contributions MUST adhere to these standards:

- **Single-Page Application**: Core app is an SPA with no build toolchain requirements
- **Progressive Enhancement**: Basic document viewing MUST work without JavaScript for SEO
- **API Rate Awareness**: Application MUST handle GitHub API rate limits gracefully (60/hr
  unauthenticated, 5000/hr authenticated)
- **Error Handling**: All API failures MUST display user-friendly messages with recovery options
- **Accessibility**: UI MUST support keyboard navigation and screen readers

**Rationale**: These standards ensure maintainability, reliability, and inclusive access
while respecting GitHub API constraints.

## Deployment Requirements

The application MUST be deployed using GitHub Pages.

**Production**:
- Production hosting MUST use GitHub Pages from the repository's configured branch
- No external hosting providers, CDNs, or custom servers are permitted for the main application
- Custom domains MAY be configured via GitHub Pages settings
- Build artifacts (if any) MUST be compatible with GitHub Pages static file serving

**Local Development**:
- The application MUST be testable from a local machine via localhost URL
- A simple HTTP server (e.g., `python -m http.server`, `npx serve`) MUST be sufficient to run locally
- No complex build pipeline or toolchain MUST be required for local testing
- All features MUST function identically in local and production environments
- OAuth flows MAY require additional configuration for localhost redirect URIs

**Rationale**: GitHub Pages deployment reinforces the Zero Backend principle and eliminates
hosting costs. Local development support enables rapid iteration and testing without
deploying to production.

## Governance

This constitution supersedes all other development practices for the Gist Review project.

**Amendment Process**:

1. Proposed changes MUST be documented with rationale
2. Changes to Core Principles require explicit justification of trade-offs
3. Version increments follow semantic versioning:
   - MAJOR: Principle removal or incompatible redefinition
   - MINOR: New principle or section added
   - PATCH: Clarifications and wording refinements

**Compliance**:

- All pull requests MUST verify alignment with Core Principles
- Deviations MUST be explicitly justified in PR descriptions
- Periodic reviews SHOULD assess principle effectiveness

**Version**: 1.2.0 | **Ratified**: 2026-01-09 | **Last Amended**: 2026-01-10
