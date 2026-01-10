# Quickstart: Gist Revision Selector

**Feature**: 5-gist-revision-selector  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-4
- Gists with multiple revisions for testing

## Implementation Steps

1. **Add revision selector HTML** to index.html:
   ```html
   <div class="revision-selector">
     <label for="revision-select">Revision:</label>
     <select id="revision-select">
       <!-- Populated by JavaScript -->
     </select>
   </div>
   ```

2. **Extract revision history** from fetched Gist:
   - Access `gist.history` array
   - Sort by `committed_at` descending (newest first)
   - Format timestamps for display

3. **Populate dropdown** with revisions:
   - Each option shows formatted timestamp
   - Latest revision selected by default
   - Option value is the revision version/SHA

4. **Handle revision selection**:
   - Fetch revision-specific content
   - Update URL with `rev` parameter
   - Use History API for navigation

5. **Handle URL parameters on load**:
   - Check for `rev` parameter
   - Load specified revision if present
   - Default to latest if not present

6. **Handle browser navigation**:
   - Listen for `popstate` event
   - Load appropriate revision on back/forward

## Testing

### Create Test Gist

1. Create a new Gist on GitHub
2. Edit it 3-5 times to create revisions
3. Use that Gist ID for testing

### Test Scenarios

1. **Load latest revision** (no rev parameter)
2. **Load specific revision** (with rev parameter)
3. **Switch revisions** via dropdown
4. **Browser back/forward** after switching
5. **Share URL** with revision parameter
6. **Gist with single revision** (selector shows one item)
7. **Gist with many revisions** (50+) - test scrolling

## Verification Steps

1. Load Gist with multiple revisions
2. Verify dropdown shows all revisions with timestamps
3. Select older revision, verify content changes
4. Check URL includes `rev` parameter
5. Copy URL, open in new tab, verify same revision loads
6. Use browser back button, verify navigation works

## Success Criteria Checklist

- [ ] Revision list displays within 3 seconds
- [ ] Switching revisions updates content within 2 seconds
- [ ] Currently selected revision is visually indicated
- [ ] URL includes revision parameter when selected
- [ ] Browser back/forward navigation works
- [ ] UI remains usable with 50+ revisions
