# Tasks: Markdown Rendering with Sanitization

**Input**: Design documents from `/specs/4-markdown-rendering/`
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

- [ ] T001 Verify Spec 3 (Fetch Public Gist) is complete and provides raw Markdown content

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T002 Add marked.js library via CDN link in /index.html
- [ ] T003 Add DOMPurify library via CDN link in /index.html
- [ ] T004 Add highlight.js library via CDN link in /index.html
- [ ] T005 [P] Add highlight.js CSS theme (e.g., github theme) via CDN in /index.html
- [ ] T006 Configure marked.js with GFM (GitHub Flavored Markdown) options in /app.js

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - View Formatted Markdown Content (Priority: P1) 🎯 MVP

**Goal**: User sees Markdown rendered as formatted HTML with headings, lists, links, and emphasis

**Independent Test**: Load a Gist with various Markdown elements and verify they render as formatted HTML.

### Implementation for User Story 1

- [ ] T007 [US1] Create renderMarkdown() function using marked.js in /app.js
- [ ] T008 [US1] Configure marked.js to render headings (H1-H6) in /app.js
- [ ] T009 [US1] Configure marked.js to render ordered and unordered lists in /app.js
- [ ] T010 [US1] Configure marked.js to render links with target="_blank" and rel="noopener noreferrer" in /app.js
- [ ] T011 [US1] Configure marked.js to render bold, italic, and text formatting in /app.js
- [ ] T012 [US1] Configure marked.js to render GFM-style tables in /app.js
- [ ] T013 [US1] Configure marked.js to render external images in /app.js
- [ ] T014 [US1] Add Markdown typography styles (headings, paragraphs, lists) in /styles.css
- [ ] T015 [US1] Add table styles for GFM tables in /styles.css
- [ ] T016 [US1] Add max-width: 100% constraint for external images in /styles.css
- [ ] T017 [US1] Integrate renderMarkdown() into content display flow in /app.js

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - View Code Blocks with Syntax Highlighting (Priority: P2)

**Goal**: User sees code blocks with monospace font and syntax highlighting

**Independent Test**: Load a Gist with fenced code blocks and verify they render with syntax highlighting.

### Implementation for User Story 2

- [ ] T018 [US2] Configure marked.js to render fenced code blocks in /app.js
- [ ] T019 [US2] Configure marked.js to render inline code in /app.js
- [ ] T020 [US2] Integrate highlight.js with marked.js for syntax highlighting in /app.js
- [ ] T021 [US2] Add code block styles (background, padding, overflow) in /styles.css
- [ ] T022 [US2] Add inline code styles (background, padding, font) in /styles.css

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Protection from Malicious Content (Priority: P1)

**Goal**: Malicious HTML/JavaScript in Gist content is sanitized and cannot execute

**Independent Test**: Load a Gist containing `<script>` tags or onclick handlers and verify they are removed.

### Implementation for User Story 3

- [ ] T023 [US3] Create sanitizeHtml() function using DOMPurify in /app.js
- [ ] T024 [US3] Configure DOMPurify to remove script tags in /app.js
- [ ] T025 [US3] Configure DOMPurify to remove event handler attributes (onclick, onerror, etc.) in /app.js
- [ ] T026 [US3] Configure DOMPurify to remove dangerous elements (iframe, embed, object) in /app.js
- [ ] T027 [US3] Configure DOMPurify to preserve safe HTML elements (em, strong, a, etc.) in /app.js
- [ ] T028 [US3] Integrate sanitization into renderMarkdown() pipeline in /app.js
- [ ] T029 [US3] Test with common XSS payloads to verify protection

**Checkpoint**: All user stories should now be independently functional

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T030 Handle malformed Markdown gracefully without crashing in /app.js
- [ ] T031 Verify content renders within 1 second after raw Markdown is received
- [ ] T032 Run quickstart.md verification steps
- [ ] T033 Test with various Markdown samples including edge cases

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User Story 3 (security) should be prioritized alongside User Story 1
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - Core rendering
- **User Story 2 (P2)**: Can start after US1 - Adds syntax highlighting
- **User Story 3 (P1)**: Should run in parallel with US1 - Security is critical

### Within Each User Story

- Library configuration before usage
- Rendering logic before styling
- Integration before testing
- Story complete before moving to next priority

### Parallel Opportunities

- T002, T003, T004, T005 can run in parallel (CDN links)
- T014, T015, T016 can run in parallel (CSS styling)
- T021, T022 can run in parallel (code styling)
- User Story 3 can run in parallel with User Story 1

---

## Summary

| Metric | Value |
|--------|-------|
| Total Tasks | 33 |
| User Story 1 Tasks | 11 |
| User Story 2 Tasks | 5 |
| User Story 3 Tasks | 7 |
| Setup/Foundational Tasks | 6 |
| Polish Tasks | 4 |
| Parallel Opportunities | 8 |
| MVP Scope | Phase 1-3 + Phase 5 (US1 + US3 for security) |
