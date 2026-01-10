# Tasks: Accessibility Enhancements

**Input**: Design documents from `/specs/14-accessibility-enhancements/`
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

- [ ] T001 Verify Spec 5 (Revision Selector) is complete
- [ ] T002 Verify Spec 7 (Display Comments) is complete
- [ ] T003 Verify Spec 10 (Visual Anchoring) is complete
- [ ] T004 Verify Spec 12 (Multi-File Support) is complete

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T005 Add skip link element ("Skip to content") at top of page in /index.html
- [ ] T006 Add ARIA live region element for dynamic announcements in /index.html
- [ ] T007 [P] Add focus indicator styles (2px solid outline, high-contrast color) in /styles.css
- [ ] T008 [P] Add skip link styles (visible on focus only) in /styles.css
- [ ] T009 Create announceToScreenReader() utility function in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Navigate Application with Keyboard Only (Priority: P1) 🎯 MVP

**Goal**: All interactive elements are reachable and usable with keyboard

**Independent Test**: Navigate through the entire application using only Tab, Shift+Tab, Enter, Escape, Arrow keys.

### Implementation for User Story 1

- [ ] T010 [US1] Ensure all interactive elements have tabindex or are naturally focusable in /index.html
- [ ] T011 [US1] Implement logical focus order (left-to-right, top-to-bottom) in /index.html
- [ ] T012 [US1] Add keyboard activation (Enter/Space) for all buttons and links in /app.js
- [ ] T013 [US1] Add arrow key navigation to revision dropdown in /app.js
- [ ] T014 [US1] Add arrow key navigation to file selector tabs in /app.js
- [ ] T015 [US1] Add keyboard navigation to text highlights (Tab between, Enter to open) in /app.js
- [ ] T016 [US1] Implement Escape key to close modals and popovers in /app.js
- [ ] T017 [US1] Implement focus trapping within open modals/popovers in /app.js
- [ ] T018 [US1] Return focus to trigger element when modal closes in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Use Screen Reader with Application (Priority: P1)

**Goal**: Screen readers announce all interactive elements and dynamic content changes

**Independent Test**: Use NVDA/VoiceOver to navigate and verify all elements are announced appropriately.

### Implementation for User Story 2

- [ ] T019 [US2] Add ARIA labels to non-text interactive elements in /index.html
- [ ] T020 [US2] Add aria-label to revision selector ("Revision selector, dropdown") in /index.html
- [ ] T021 [US2] Add aria-label to file selector tabs in /index.html
- [ ] T022 [US2] Add aria-label to comment highlights (e.g., "Comment highlight, 3 comments") in /app.js
- [ ] T023 [US2] Add ARIA roles to custom UI components in /index.html
- [ ] T024 [US2] Add role="tablist" to file selector, role="tab" to tabs in /index.html
- [ ] T025 [US2] Add aria-selected state to selected tab in /app.js
- [ ] T026 [US2] Use ARIA live region for content loading announcements in /app.js
- [ ] T027 [US2] Use ARIA live region for revision change announcements in /app.js
- [ ] T028 [US2] Use aria-live="polite" for most updates, "assertive" for errors in /app.js

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Understand Focus Location Visually (Priority: P2)

**Goal**: All focusable elements have clear visible focus indicators

**Independent Test**: Tab through elements and verify each one has a visible focus style.

### Implementation for User Story 3

- [ ] T029 [US3] Add focus-visible styles to buttons in /styles.css
- [ ] T030 [US3] Add focus-visible styles to links in /styles.css
- [ ] T031 [US3] Add focus-visible styles to dropdown/select elements in /styles.css
- [ ] T032 [US3] Add focus-visible styles to tabs in /styles.css
- [ ] T033 [US3] Add focus-visible styles to text highlights in /styles.css
- [ ] T034 [US3] Ensure focus indicators have sufficient color contrast (WCAG AA) in /styles.css
- [ ] T035 [US3] Preserve custom focus styles when browser defaults are overridden in /styles.css

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Keyboard Shortcuts

**Purpose**: Provide shortcuts for common actions

- [ ] T036 Implement Escape key handler for closing modals globally in /app.js
- [ ] T037 Implement / key to focus search (if search exists) in /app.js
- [ ] T038 Implement ? key to show keyboard help dialog in /app.js
- [ ] T039 Create keyboard help dialog listing available shortcuts in /index.html
- [ ] T040 [P] Add keyboard help dialog styles in /styles.css

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T041 Run automated accessibility testing (axe-core) and fix issues
- [ ] T042 Test with NVDA on Windows
- [ ] T043 Test with VoiceOver on macOS
- [ ] T044 Verify WCAG 2.1 AA compliance
- [ ] T045 Run quickstart.md verification steps

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-5)**: All depend on Foundational phase completion
  - US2 can run in parallel with US1
- **Keyboard Shortcuts (Phase 6)**: Depends on US1 for keyboard handling
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Keyboard navigation
- **User Story 2 (P1)**: Can start after Foundational - Screen reader support
- **User Story 3 (P2)**: Can start after Foundational - Focus indicators

### Within Each User Story

- HTML structure before ARIA attributes
- ARIA attributes before JavaScript handlers
- Core functionality before edge cases
- Story complete before moving to next priority

### Parallel Opportunities

- T005, T006, T007, T008 can run in parallel (HTML/CSS setup)
- T010, T11, T12 can run in parallel (basic keyboard support)
- T019-T24 can run in parallel (ARIA labeling)
- T029-T35 can run in parallel (focus styling)
- US1, US2, US3 can all run in parallel

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 45 |
| User Story 1 Tasks | 9 |
| User Story 2 Tasks | 10 |
| User Story 3 Tasks | 7 |
| Setup/Foundational Tasks | 9 |
| Keyboard Shortcuts Tasks | 5 |
| Polish Tasks | 5 |
| Parallel Opportunities | 12 |
| MVP Scope | Phase 1-4 (US1 + US2) |
