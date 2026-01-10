# Research: URL Parameter Routing

**Feature**: 2-url-parameter-routing  
**Date**: 2026-01-10

## Research Tasks

### 1. URL Parsing API

**Decision**: Use native `URLSearchParams` API for query parameter extraction.

**Rationale**: 
- Native browser API, no dependencies needed
- Handles URL decoding automatically
- Well-supported in all modern browsers

**Alternatives Considered**:
- Manual regex parsing - Rejected: More error-prone, URLSearchParams is standard
- Third-party routing library - Rejected: Overkill for simple parameter extraction

### 2. Gist URL Format Parsing

**Decision**: Extract Gist ID from full URLs by taking the last path segment after stripping trailing slashes and fragments.

**Rationale**:
- GitHub Gist URLs follow pattern: `https://gist.github.com/{username}/{gist_id}`
- The Gist ID is always the last path segment
- This approach works for both public GitHub and Enterprise instances

**Pattern Matching**:
```javascript
// Full URL: extract last path segment
// https://gist.github.com/user/abc123 → abc123
// https://gist.github.com/user/abc123/ → abc123
// https://gist.github.com/abc123 → abc123 (anonymous gist)
```

**Alternatives Considered**:
- Regex for specific domain - Rejected: Breaks for Enterprise instances
- URL constructor with domain validation - Rejected: Unnecessary complexity

### 3. Bare ID Detection

**Decision**: If the value doesn't start with `http://` or `https://`, treat it as a bare Gist ID.

**Rationale**:
- Simple heuristic that covers all cases
- GitHub Gist IDs are alphanumeric (hex format)
- No need to validate format; let GitHub API reject invalid IDs later

**Alternatives Considered**:
- Validate hex format - Rejected: GitHub might change ID format; let API validate
- Validate length - Rejected: IDs vary in length

### 4. Multiple Parameters Handling

**Decision**: Use `URLSearchParams.get()` which returns only the first value for duplicate keys.

**Rationale**:
- Matches FR-008 requirement
- Native behavior of URLSearchParams
- Predictable, spec-compliant

### 5. Display Format

**Decision**: Display as labeled format: "Gist ID: {id}" in the main content area.

**Rationale**:
- Clear and unambiguous
- Required by FR-004 in spec
- Simple to implement

## Technical Decisions Summary

| Topic | Decision | Rationale |
|-------|----------|-----------|
| URL Parsing | Native URLSearchParams | Standard API, no dependencies |
| Full URL Extraction | Last path segment | Works for all GitHub instances |
| Bare ID Detection | Check for http(s):// prefix | Simple, reliable |
| Multiple Params | Use first value (URLSearchParams default) | Spec requirement |
| Display | "Gist ID: {id}" format | Spec requirement |
