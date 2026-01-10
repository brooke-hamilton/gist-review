# Tasks: Progressive Enhancement & SEO

**Input**: Design documents from `/specs/15-progressive-enhancement-seo/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Tests**: Tests are OPTIONAL - not explicitly requested in this feature specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: Files at repository root (`/`)
- Structure: `index.html`, `styles.css`, `app.js`, `og-image.png`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Verify Spec 4 (Markdown Rendering) is complete

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T002 Create og-image.png branded preview image (logo + app name on solid background) in /og-image.png
- [ ] T003 Verify semantic HTML structure exists (header, main, nav, footer) in /index.html

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View Page with JavaScript Disabled (Priority: P1) 🎯 MVP

**Goal**: Page displays meaningful content when JavaScript is disabled

**Independent Test**: Disable JavaScript in browser and verify the page shows meaningful content.

### Implementation for User Story 1

- [ ] T004 [US1] Add noscript element with fallback content in /index.html
- [ ] T005 [US1] Include app logo in noscript fallback in /index.html
- [ ] T006 [US1] Include "Gist Review" title in noscript fallback in /index.html
- [ ] T007 [US1] Include brief feature list in noscript fallback in /index.html
- [ ] T008 [US1] Include "Gist Review requires JavaScript" message in noscript fallback in /index.html
- [ ] T009 [US1] Include link to GitHub repository in noscript fallback in /index.html
- [ ] T010 [US1] Ensure basic page structure is visible without JavaScript in /index.html
- [ ] T011 [P] [US1] Add noscript fallback styles in /styles.css

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Share Link on Social Media (Priority: P1)

**Goal**: Shared links display rich previews on social media platforms

**Independent Test**: Share URL on Slack or use Twitter Card Validator to verify preview.

### Implementation for User Story 2

- [ ] T012 [US2] Add og:title meta tag ("Gist Review") in /index.html
- [ ] T013 [US2] Add og:description meta tag in /index.html
- [ ] T014 [US2] Add og:image meta tag pointing to og-image.png in /index.html
- [ ] T015 [US2] Add og:url meta tag in /index.html
- [ ] T016 [US2] Add og:type meta tag ("website") in /index.html
- [ ] T017 [US2] Add twitter:card meta tag ("summary") in /index.html
- [ ] T018 [US2] Add twitter:title meta tag in /index.html
- [ ] T019 [US2] Add twitter:description meta tag in /index.html
- [ ] T020 [US2] Add twitter:image meta tag in /index.html
- [ ] T021 [US2] Properly escape special characters in meta tag content in /index.html

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - SEO-Friendly Page Structure (Priority: P2)

**Goal**: Page has proper structure and meta tags for search engines

**Independent Test**: Inspect page source for semantic HTML and proper meta tags.

### Implementation for User Story 3

- [ ] T022 [US3] Add proper title tag ("Gist Review - Review GitHub Gists") in /index.html
- [ ] T023 [US3] Add meta description tag in /index.html
- [ ] T024 [US3] Add meta charset tag (UTF-8) in /index.html
- [ ] T025 [US3] Add meta viewport tag in /index.html
- [ ] T026 [US3] Verify semantic HTML elements are properly nested in /index.html
- [ ] T027 [US3] Add lang attribute to html element in /index.html

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T028 Verify page is readable when CSS fails to load
- [ ] T029 Run Lighthouse SEO audit and target score > 90
- [ ] T030 Test social preview with Twitter Card Validator
- [ ] T031 Test social preview with Facebook Sharing Debugger
- [ ] T032 Run quickstart.md verification steps

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - All user stories can run in parallel
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Noscript fallback
- **User Story 2 (P1)**: Can start after Foundational (Phase 2) - Social meta tags
- **User Story 3 (P2)**: Can start after Foundational (Phase 2) - SEO structure

### Within Each User Story

- HTML meta tags before content
- Content before styling
- Static content before dynamic
- Story complete before moving to next priority

### Parallel Opportunities

- All user stories can run in parallel (independent HTML additions)
- T004-T10 can run in parallel (noscript content)
- T012-T20 can run in parallel (Open Graph/Twitter tags)
- T022-T27 can run in parallel (SEO meta tags)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 32 |
| User Story 1 Tasks | 8 |
| User Story 2 Tasks | 10 |
| User Story 3 Tasks | 6 |
| Setup/Foundational Tasks | 3 |
| Polish Tasks | 5 |
| Parallel Opportunities | 12 |
| MVP Scope | Phase 1-4 (US1 + US2) |
