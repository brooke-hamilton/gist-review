# Quickstart: Fetch and Display Gist Comments

**Feature**: 7-display-gist-comments  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-6
- Gists with comments for testing

## Implementation Steps

1. **Add js-yaml to index.html**:
   ```html
   <script src="https://cdn.jsdelivr.net/npm/js-yaml/dist/js-yaml.min.js"></script>
   ```

2. **Add sidebar HTML structure**:
   ```html
   <div class="layout">
     <main class="content-area">
       <!-- Existing content -->
     </main>
     <aside class="comment-sidebar" id="comment-sidebar">
       <div class="sidebar-header">
         <h2>Comments</h2>
         <button id="sidebar-toggle" aria-label="Toggle sidebar">
           <span class="collapse-icon">→</span>
         </button>
       </div>
       <div class="comment-list" id="comment-list">
         <!-- Comments populated by JavaScript -->
       </div>
     </aside>
   </div>
   ```

3. **Add sidebar CSS**:
   - Flexbox layout with content and sidebar
   - Collapsible animation
   - Comment card styling

4. **Implement comment fetching**:
   - Call GitHub API for comments
   - Handle pagination if needed
   - Parse front matter from each comment

5. **Implement comment rendering**:
   - Group anchored vs unanchored
   - Sort by anchor position, then chronologically
   - Display author, time, and content

6. **Add collapse/expand toggle**:
   - Toggle button in header
   - Save preference in sessionStorage

## Test Scenarios

### Create Test Comments

1. Find/create a Gist with multiple files
2. Add comments manually on GitHub:
   - Plain comment (no front matter)
   - Comment with YAML front matter:
     ```
     ---
     line_start: 5
     line_end: 7
     revision: abc123
     ---
     This is an anchored comment.
     ```

### Test Cases

1. **Public Gist comments** - View without login
2. **No comments** - Empty state message
3. **Many comments** - Scrollable list
4. **Malformed front matter** - Treated as plain comment
5. **Collapse/expand** - Toggle sidebar
6. **Rendered Markdown** - Comments with formatting

## Verification Steps

1. Load Gist with comments
2. Verify sidebar appears on right
3. Verify all comments are listed
4. Verify author and timestamp visible
5. Verify front matter is parsed (not shown in content)
6. Verify collapse/expand works
7. Check "no comments" state for empty Gist

## Success Criteria Checklist

- [ ] Comments display within 3 seconds
- [ ] Public Gist comments viewable without auth
- [ ] Author and timestamp shown for each comment
- [ ] Front matter correctly parsed (YAML and JSON)
- [ ] Sidebar collapsible with toggle button
- [ ] Usable with 50+ comments (scrollable)
