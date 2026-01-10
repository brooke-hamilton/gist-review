# Tasks: URL Parameter Routing

**Input**: Design documents from `/specs/2-url-parameter-routing/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

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

- [ ] T001 Verify Spec 1 (Static Site Foundation) is complete with index.html, styles.css, app.js

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T002 Create URL parameter parsing utility function using URLSearchParams API in /app.js
- [ ] T003 Create Gist ID extraction utility function that handles both bare IDs and full URLs in /app.js
- [ ] T004 Add DOMContentLoaded event listener to initialize URL parsing on page load in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Access Gist via Bare ID (Priority: P1) 🎯 MVP

**Goal**: User navigates to `?gist=abc123` and sees the Gist ID displayed on the page

**Independent Test**: Navigate to `?gist=abc123` and verify "abc123" appears on the page as the identified Gist ID.

### Implementation for User Story 1

- [ ] T005 [US1] Implement parseGistParameter() function to extract gist query parameter in /app.js
- [ ] T006 [US1] Implement displayGistId() function to show Gist ID in main content area in /app.js
- [ ] T007 [US1] Add labeled display format (e.g., "Gist ID: abc123") to main content area in /app.js
- [ ] T008 [US1] Style the Gist ID display element in /styles.css
- [ ] T009 [US1] Wire up URL parsing on page load to display extracted Gist ID in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Access Gist via Full GitHub URL (Priority: P2)

**Goal**: User pastes a full GitHub Gist URL and the app extracts the Gist ID

**Independent Test**: Navigate to `?gist=https://gist.github.com/user/abc123` and verify "abc123" appears on the page.

### Implementation for User Story 2

- [ ] T010 [US2] Implement extractGistIdFromUrl() function to parse GitHub Gist URLs in /app.js
- [ ] T011 [US2] Handle URL patterns: <https://gist.github.com/{username}/{gist_id}> in /app.js
- [ ] T012 [US2] Handle trailing slashes and hash fragments in Gist URLs in /app.js
- [ ] T013 [US2] Handle URL-encoded characters in the parameter value in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Handle Missing or Invalid Parameter (Priority: P3)

**Goal**: User sees helpful guidance when no gist parameter is provided

**Independent Test**: Navigate to the app without any query parameters and verify a helpful message appears.

### Implementation for User Story 3

- [ ] T014 [US3] Implement showGuidanceMessage() function to display help text in /app.js
- [ ] T015 [US3] Display message with example URL (e.g., "Add ?gist=YOUR_GIST_ID to the URL") in /app.js
- [ ] T016 [US3] Handle empty gist parameter value (?gist=) with same guidance message in /app.js
- [ ] T017 [US3] Style the guidance message element in /styles.css

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T018 Handle multiple gist parameters by using only the first value in /app.js
- [ ] T019 Verify Gist ID display appears within 1 second of page load
- [ ] T020 Run quickstart.md verification steps
- [ ] T021 Test with bookmarked URLs to verify state persistence

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
- **User Story 2 (P2)**: Can start after US1 - Extends the extraction logic
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Independent error handling

### Within Each User Story

- Utility functions before display logic
- Logic before styling
- Story complete before moving to next priority

### Parallel Opportunities

- T005, T006 can run in parallel (different functions)
- T010, T011, T012, T013 can run in parallel (URL parsing variations)
- User Story 3 can run in parallel with User Story 2

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 21 |
| User Story 1 Tasks | 5 |
| User Story 2 Tasks | 4 |
| User Story 3 Tasks | 4 |
| Setup/Foundational Tasks | 4 |
| Polish Tasks | 4 |
| Parallel Opportunities | 6 |
| MVP Scope | Phase 1-3 (User Story 1) |
