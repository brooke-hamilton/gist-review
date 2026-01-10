# Quickstart: Multi-File Gist Support

**Feature**: 12-multi-file-support  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-11
- Test Gist with multiple files (Markdown and code)

## Implementation Steps

1. **Add file tab bar CSS**:
   ```css
   .file-tabs {
     display: flex;
     overflow-x: auto;
     border-bottom: 1px solid var(--border-color);
     background: var(--bg-secondary);
     scrollbar-width: thin;
   }
   
   .file-tabs::-webkit-scrollbar {
     height: 4px;
   }
   
   .file-tabs button {
     white-space: nowrap;
     padding: 12px 16px;
     border: none;
     border-bottom: 2px solid transparent;
     background: transparent;
     cursor: pointer;
     font-size: 0.875rem;
   }
   
   .file-tabs button:hover {
     background: var(--bg-hover);
   }
   
   .file-tabs button[aria-selected="true"] {
     border-bottom-color: var(--accent-color);
     font-weight: 600;
   }
   
   .file-tabs.hidden {
     display: none;
   }
   ```

2. **Add tab bar HTML**:
   ```html
   <nav class="file-tabs hidden" role="tablist" aria-label="Gist files">
   </nav>
   ```

3. **Implement file extraction**:
   - On Gist load, extract all files
   - Sort alphabetically
   - Store in application state
   - Show/hide tabs based on file count

4. **Implement file selection**:
   - Read `?file=` from URL on load
   - Default to first file if not specified
   - Update URL on file change
   - Handle missing file gracefully

5. **Implement content rendering**:
   - Check file extension for Markdown
   - Render Markdown files with marked.js
   - Render code files with highlight.js
   - Update content area on file switch

6. **Update comment handling**:
   - Filter comments by file
   - Update highlights for selected file
   - Include file in new comment metadata

## Testing

### Test Scenarios

1. **Single-file Gist** - No tab bar visible
2. **Multi-file Gist** - Tab bar with all files
3. **File switch** - Content updates on tab click
4. **URL sync** - URL updates with file param
5. **URL load** - Open URL with file param, correct file shown
6. **Missing file** - Falls back to first file
7. **Special chars** - File with spaces/symbols works
8. **Many files** - 20+ files scrollable
9. **Non-Markdown** - JS/JSON files syntax highlighted
10. **File-specific comments** - Only current file's comments shown

### Create Test Data

1. Create Gist with:
   - `README.md` (Markdown)
   - `app.js` (JavaScript)
   - `config.json` (JSON)
   - `notes.txt` (Plain text)
2. Add comments to different files
3. Test file switching and comment filtering

## Verification Steps

1. Load multi-file Gist
2. Verify tab bar appears with all files
3. Click different tabs, verify content updates
4. Verify URL includes `?file=` parameter
5. Copy URL, open in new tab, verify same file
6. Verify comments filter per file
7. Create comment, verify file in metadata
8. Load single-file Gist, verify no tab bar

## Success Criteria Checklist

- [ ] Tab bar visible for multi-file Gists
- [ ] Tab bar hidden for single-file Gists
- [ ] Selected file visually indicated
- [ ] File switch within 500ms
- [ ] URL updates with file parameter
- [ ] URL with file param loads correct file
- [ ] Missing file falls back to first
- [ ] Comments filter by selected file
- [ ] New comments include filename
- [ ] Non-Markdown files syntax highlighted
