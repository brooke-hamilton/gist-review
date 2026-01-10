# Tasks: Fetch and Display Gist Comments

**Input**: Design documents from `/specs/7-display-gist-comments/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md, contracts/

**Tests**: Tests are OPTIONAL - not explicitly requested in this feature specification.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: Files at repository root (`/`)
- Structure: `index.html`, `styles.css`, `app.js`

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Verify Spec 3 (Fetch Public Gist) is complete
- [ ] T002 Verify Spec 4 (Markdown Rendering) is complete for comment body formatting
- [ ] T003 Verify Spec 6 (GitHub OAuth) is complete for authenticated requests

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 Add js-yaml library via CDN link for YAML parsing in /index.html
- [ ] T005 Create right sidebar element for comments in /index.html
- [ ] T006 Add sidebar toggle button element in /index.html
- [ ] T007 [P] Add sidebar layout styles (content on left, sidebar on right) in /styles.css
- [ ] T008 [P] Add sidebar collapse/expand styles in /styles.css
- [ ] T009 Create fetchGistComments() function skeleton in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View Comments on Public Gist (Priority: P1) 🎯 MVP

**Goal**: User loads a public Gist and sees comments displayed in the sidebar

**Independent Test**: Load a public Gist with comments and verify comments appear in the sidebar without authentication.

### Implementation for User Story 1

- [ ] T010 [US1] Implement fetchGistComments() to call GitHub Gist Comments API in /app.js
- [ ] T011 [US1] Parse comment data from API response (author, timestamp, body) in /app.js
- [ ] T012 [US1] Create renderComment() function to display individual comment in /app.js
- [ ] T013 [US1] Display comment author avatar and username in /app.js
- [ ] T014 [US1] Display comment timestamp in /app.js
- [ ] T015 [US1] Render comment body as Markdown using existing renderer in /app.js
- [ ] T016 [US1] Populate sidebar with comment list in /app.js
- [ ] T017 [US1] Show "No comments yet" message for Gists without comments in /app.js
- [ ] T018 [US1] Implement sidebar toggle button functionality in /app.js
- [ ] T019 [US1] Default sidebar to expanded state in /app.js
- [ ] T020 [P] [US1] Add comment card styles (author, timestamp, body) in /styles.css

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - View Comments on Private Gist (Priority: P2)

**Goal**: Authenticated user can view comments on private Gists

**Independent Test**: Log in, load a private Gist with comments, and verify comments appear.

### Implementation for User Story 2

- [ ] T021 [US2] Modify fetchGistComments() to include auth token when available in /app.js
- [ ] T022 [US2] Handle 403/404 for private Gists with login prompt in /app.js
- [ ] T023 [US2] Display "Log in to view comments" message for private Gists when unauthenticated in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - View Parsed Review Metadata (Priority: P2)

**Goal**: Comments with YAML/JSON front matter have metadata parsed and extracted

**Independent Test**: Load a Gist with comments containing front matter and verify metadata is parsed.

### Implementation for User Story 3

- [ ] T024 [US3] Create parseFrontMatter() function to extract YAML/JSON metadata in /app.js
- [ ] T025 [US3] Detect front matter delimiter (---) at start of comment body in /app.js
- [ ] T026 [US3] Parse YAML front matter using js-yaml library in /app.js
- [ ] T027 [US3] Parse JSON front matter as fallback in /app.js
- [ ] T028 [US3] Handle malformed front matter gracefully (treat as no front matter) in /app.js
- [ ] T029 [US3] Extract comment body (text after front matter) for display in /app.js
- [ ] T030 [US3] Store parsed metadata on comment object for anchoring features in /app.js

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Comment Ordering

**Purpose**: Order comments by anchor position for contextual display

- [ ] T031 Sort comments by anchor position (line number) from front matter in /app.js
- [ ] T032 Within same anchor, sort chronologically (oldest first) in /app.js
- [ ] T033 Display unanchored comments after anchored comments in /app.js

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T034 Handle comment fetch errors with user-friendly messages in /app.js
- [ ] T035 Handle large comment threads (50+) with scrollable sidebar in /styles.css
- [ ] T036 Verify comments display within 3 seconds of loading a Gist
- [ ] T037 Run quickstart.md verification steps
- [ ] T038 Test with Gists containing various comment formats

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - US2 depends on authentication from Spec 6
  - US3 depends on US1 for comment display
- **Comment Ordering (Phase 6)**: Depends on US3 for front matter parsing
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Core comment display
- **User Story 2 (P2)**: Can start after US1 - Auth integration
- **User Story 3 (P2)**: Can start after US1 - Front matter parsing

### Within Each User Story

- API calls before parsing
- Parsing before rendering
- Rendering before styling
- Story complete before moving to next priority

### Parallel Opportunities

- T007, T008 can run in parallel (CSS styling)
- T010, T011 can run in parallel (API and parsing)
- T020 can run in parallel with T16-T19 (CSS styling)
- US2 and US3 can run in parallel after US1

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 38 |
| User Story 1 Tasks | 11 |
| User Story 2 Tasks | 3 |
| User Story 3 Tasks | 7 |
| Setup/Foundational Tasks | 9 |
| Comment Ordering Tasks | 3 |
| Polish Tasks | 5 |
| Parallel Opportunities | 8 |
| MVP Scope | Phase 1-3 (User Story 1) |
