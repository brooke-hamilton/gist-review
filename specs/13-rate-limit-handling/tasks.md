# Tasks: Rate Limit Handling

**Input**: Design documents from `/specs/13-rate-limit-handling/`
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

- [ ] T001 Verify Spec 3 (Fetch Public Gist) is complete and makes API requests
- [ ] T002 Verify Spec 6 (GitHub OAuth) is complete for authenticated requests

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T003 Create rate limit state object (remaining, limit, resetTime) in /app.js
- [ ] T004 Create rate limit indicator element in header in /index.html
- [ ] T005 [P] Add rate limit indicator styles (small, unobtrusive) in /styles.css
- [ ] T006 Create parseRateLimitHeaders() function in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View Rate Limit Status (Priority: P1) 🎯 MVP

**Goal**: User can see current rate limit status (remaining/total) in the header

**Independent Test**: Make API requests and verify the rate limit status is visible in the UI.

### Implementation for User Story 1

- [ ] T007 [US1] Parse X-RateLimit-Remaining header from API responses in /app.js
- [ ] T008 [US1] Parse X-RateLimit-Limit header from API responses in /app.js
- [ ] T009 [US1] Parse X-RateLimit-Reset header from API responses in /app.js
- [ ] T010 [US1] Update rate limit state after each API request in /app.js
- [ ] T011 [US1] Display rate limit as fraction (e.g., "45/60 remaining") in header in /app.js
- [ ] T012 [US1] Update display after each API request in /app.js
- [ ] T013 [US1] Distinguish between authenticated (5000/hr) and unauthenticated (60/hr) limits in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Handle Rate Limit Reached (Priority: P1)

**Goal**: User sees clear message when rate limit is exceeded with reset time

**Independent Test**: Exhaust the rate limit and verify a user-friendly message appears with reset time.

### Implementation for User Story 2

- [ ] T014 [US2] Detect 403 response with rate limit exceeded in /app.js
- [ ] T015 [US2] Display "Rate limit exceeded" message in /app.js
- [ ] T016 [US2] Calculate countdown to reset (e.g., "Resets in 23 minutes") in /app.js
- [ ] T017 [US2] Display countdown timer to reset in /app.js
- [ ] T018 [US2] Update countdown periodically in /app.js
- [ ] T019 [US2] Clear rate limit message when reset time passes in /app.js
- [ ] T020 [P] [US2] Add rate limit error message styles in /styles.css

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Suggest Authentication for Higher Limits (Priority: P2)

**Goal**: Unauthenticated users hitting rate limit see suggestion to log in

**Independent Test**: Hit rate limit while unauthenticated and verify the message suggests logging in.

### Implementation for User Story 3

- [ ] T021 [US3] Check authentication state when rate limit is reached in /app.js
- [ ] T022 [US3] Add "Log in for higher limits" suggestion for unauthenticated users in /app.js
- [ ] T023 [US3] Add login button/link in rate limit message in /app.js
- [ ] T024 [US3] Omit login suggestion for already authenticated users in /app.js

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Low Rate Limit Warning

**Purpose**: Warn users before they hit the limit

- [ ] T025 Display warning when rate limit falls below 10 remaining in /app.js
- [ ] T026 Add visual warning indicator (color change) to rate limit display in /app.js
- [ ] T027 [P] Add warning state styles for rate limit indicator in /styles.css

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T028 Handle missing rate limit headers gracefully in /app.js
- [ ] T029 Verify rate limit status updates within 1 second of API request
- [ ] T030 Run quickstart.md verification steps
- [ ] T031 Test with both authenticated and unauthenticated sessions

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - US2 depends on US1 for rate limit tracking
  - US3 depends on US2 for rate limit message
- **Low Rate Limit Warning (Phase 6)**: Depends on US1 for rate limit display
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Rate limit display
- **User Story 2 (P1)**: Depends on US1 - Rate limit exceeded handling
- **User Story 3 (P2)**: Depends on US2 - Login suggestion

### Within Each User Story

- Header parsing before state update
- State update before display
- Core functionality before edge cases
- Story complete before moving to next priority

### Parallel Opportunities

- T004, T005 can run in parallel (HTML and CSS)
- T007, T008, T009 can run in parallel (header parsing)
- T020 can run in parallel with T14-T19 (CSS styling)
- T027 can run in parallel with T25, T26 (warning styling)

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 31 |
| User Story 1 Tasks | 7 |
| User Story 2 Tasks | 7 |
| User Story 3 Tasks | 4 |
| Setup/Foundational Tasks | 6 |
| Low Rate Limit Warning Tasks | 3 |
| Polish Tasks | 4 |
| Parallel Opportunities | 6 |
| MVP Scope | Phase 1-4 (US1 + US2) |
