# Tasks: Static Site Foundation

**Input**: Design documents from `/specs/1-static-site-foundation/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Tests**: Tests are OPTIONAL - not explicitly requested in this feature specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: Files at repository root (`/`)
- Structure: `index.html`, `styles.css`, `app.js`, `assets/`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Create repository root structure for static site files
- [ ] T002 [P] Create assets/ directory for static assets

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T003 Create base index.html with DOCTYPE, html, head, and body elements in /index.html
- [ ] T004 [P] Create empty styles.css file linked from index.html in /styles.css
- [ ] T005 [P] Create empty app.js file linked from index.html in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View Application Shell in Browser (Priority: P1) 🎯 MVP

**Goal**: User opens the app and sees a clean, well-structured page with header, main content area, and footer

**Independent Test**: Open index.html in any modern browser and verify the header displays "Gist Review" and the main content area is visible.

### Implementation for User Story 1

- [ ] T006 [US1] Add semantic header element with "Gist Review" title in /index.html
- [ ] T007 [US1] Add semantic main element for content area in /index.html
- [ ] T008 [US1] Add semantic footer element with copyright notice in /index.html
- [ ] T009 [US1] Add CSS custom properties (variables) for colors supporting light/dark themes in /styles.css
- [ ] T010 [US1] Add prefers-color-scheme media query for automatic dark mode in /styles.css
- [ ] T011 [US1] Add base typography and reset styles in /styles.css
- [ ] T012 [US1] Style header section with app title in /styles.css
- [ ] T013 [US1] Style main content area with max-width 1200px and centered layout in /styles.css
- [ ] T014 [US1] Style footer section in /styles.css
- [ ] T015 [US1] Add mobile-first responsive styles with breakpoint at 768px in /styles.css
- [ ] T016 [US1] Verify page renders correctly without JavaScript enabled

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Serve Application Locally for Development (Priority: P2)

**Goal**: Developer can test the application locally using a simple HTTP server

**Independent Test**: Run `python -m http.server` or `npx serve` in the repository root and open the URL in browser.

### Implementation for User Story 2

- [ ] T017 [US2] Verify application works with python -m http.server 8000
- [ ] T018 [US2] Verify application works with npx serve
- [ ] T019 [US2] Verify file changes reflect on browser refresh without build step

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Deploy to GitHub Pages (Priority: P3)

**Goal**: Application is deployable to GitHub Pages and accessible at the GitHub Pages URL

**Independent Test**: Enable GitHub Pages in repository settings and verify the site loads at `https://{owner}.github.io/gist-review/`.

### Implementation for User Story 3

- [ ] T020 [US3] Ensure all file paths are relative for GitHub Pages compatibility in /index.html
- [ ] T021 [US3] Test deployment by enabling GitHub Pages in repository settings

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T022 [P] Add optional logo.svg to /assets/ directory (placeholder or simple logo)
- [ ] T023 Verify CSS fallback rendering when styles fail to load
- [ ] T024 Run quickstart.md verification steps
- [ ] T025 Verify page load time is under 1 second

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Validates US1 works locally
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Validates deployment

### Within Each User Story

- HTML structure before CSS styling
- Base styles before responsive styles
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- T009, T010, T011 can run in parallel (CSS base work)
- T012, T013, T014 can run in parallel (component styling)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 25 |
| User Story 1 Tasks | 11 |
| User Story 2 Tasks | 3 |
| User Story 3 Tasks | 2 |
| Setup/Foundational Tasks | 5 |
| Polish Tasks | 4 |
| Parallel Opportunities | 8 |
| MVP Scope | Phase 1-3 (User Story 1) |
