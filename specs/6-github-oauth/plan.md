# Implementation Plan: GitHub OAuth Authentication

**Branch**: `6-github-oauth` | **Date**: 2026-01-10 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/6-github-oauth/spec.md`

## Summary

Implement GitHub OAuth authentication using the Device Flow (no backend required). Request only the `gist` scope. Store access tokens in localStorage. Display login/logout state in the UI header with user avatar and username.

## Technical Context

**Language/Version**: JavaScript ES6+  
**Primary Dependencies**: None (native Fetch API)  
**Storage**: localStorage for access token, user profile  
**Testing**: Manual OAuth flow testing  
**Target Platform**: Web browsers (GitHub Pages deployment)
**Project Type**: Web/SPA  
**Performance Goals**: Login flow complete within 30 seconds  
**Constraints**: No backend, Device Flow only, gist scope only  
**Scale/Scope**: Single-page application with authentication

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Markdown-First | N/A | No document modification |
| II. Zero Backend | ✅ PASS | Device Flow requires no backend |
| III. GitHub-Native | ✅ PASS | GitHub OAuth, minimal scope |
| IV. Shareable by Default | ✅ PASS | Auth state doesn't affect URLs |
| V. Contextual Anchoring | N/A | Enables comment creation |
| Security Requirements | ✅ PASS | localStorage, gist scope only |
| Development Standards | ✅ PASS | Handles token expiration |
| Deployment Requirements | ✅ PASS | Works with localhost |

## Project Structure

### Documentation (this feature)

```text
specs/6-github-oauth/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
└── contracts/           # Phase 1 output
    └── github-device-flow-api.md
```

### Source Code (repository root)

```text
/
├── index.html           # Updated with login UI in header
├── styles.css           # Extended with auth UI styles
└── app.js              # Extended with OAuth logic
```

**Structure Decision**: Continue using single app.js file with auth management functions.

## Complexity Tracking

> No violations. This feature aligns fully with the constitution.
