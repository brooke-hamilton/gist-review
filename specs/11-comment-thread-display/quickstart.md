# Quickstart: Comment Thread Display

**Feature**: 11-comment-thread-display  
**Date**: 2026-01-10

## Prerequisites

- Completed Specs 1-10 (especially Spec 10 for highlight click handling)
- Test Gist with multiple overlapping comments

## Implementation Steps

1. **Add thread panel CSS**:

   ```css
   .thread-panel {
     position: absolute;
     top: 0;
     left: 0;
     right: 0;
     bottom: 0;
     background: var(--bg-primary);
     z-index: 100;
     display: none;
     flex-direction: column;
   }
   
   .thread-panel.open {
     display: flex;
   }
   
   .thread-header {
     display: flex;
     justify-content: space-between;
     padding: 16px;
     border-bottom: 1px solid var(--border-color);
   }
   
   .thread-comments {
     flex: 1;
     overflow-y: auto;
     padding: 16px;
   }
   
   .thread-comment {
     margin-bottom: 16px;
     padding-bottom: 16px;
     border-bottom: 1px solid var(--border-color);
   }
   
   .thread-comment:last-child {
     border-bottom: none;
   }
   
   .comment-meta {
     display: flex;
     gap: 8px;
     margin-bottom: 8px;
     font-size: 0.875rem;
   }
   
   .comment-author {
     font-weight: 600;
   }
   
   .comment-time {
     color: var(--text-muted);
     cursor: help;
   }
   
   .thread-reply {
     padding: 16px;
     border-top: 1px solid var(--border-color);
   }
   
   .thread-reply textarea {
     width: 100%;
     min-height: 60px;
     margin-bottom: 8px;
   }
   ```

2. **Implement thread grouping**:
   - After loading comments, group by overlapping anchors
   - Store threads in application state
   - Update Spec 10 click handler to open thread panel

3. **Implement thread panel rendering**:
   - Header with close button
   - Scrollable comment list
   - Each comment shows author, relative time, body
   - Reply input at bottom (if authenticated)

4. **Implement relative timestamps**:
   - Use Intl.RelativeTimeFormat
   - Show absolute time on hover via title attribute

5. **Implement close behavior**:
   - Close button in header
   - Click outside detection
   - ESC key support (accessibility)

6. **Connect reply to Spec 9**:
   - Reply inherits anchor from thread
   - Uses same API call as new comment
   - Adds to thread on success

## Testing

### Test Scenarios

1. **Single comment** - Click highlight with one comment
2. **Thread display** - Click highlight with overlapping comments
3. **Thread order** - Verify oldest first
4. **Relative time** - Check "2 hours ago" format
5. **Absolute time hover** - Tooltip shows full date
6. **Close button** - Click X closes panel
7. **Click outside** - Click outside closes panel
8. **Reply** - Submit reply, verify appears in thread
9. **Large thread** - 10+ comments scrolls properly
10. **Unknown author** - Deleted account shows placeholder

## Verification Steps

1. Load Gist with overlapping anchored comments
2. Click highlight, verify thread panel opens
3. Verify comments ordered oldest first
4. Verify relative timestamps with hover tooltips
5. Click close button, verify panel closes
6. Open thread, click outside, verify closes
7. If authenticated, submit reply, verify added

## Success Criteria Checklist

- [ ] Thread panel opens within 500ms
- [ ] Comments grouped by overlapping anchors
- [ ] Oldest comment first in thread
- [ ] Author and relative time visible
- [ ] Absolute time on hover
- [ ] Close via button works
- [ ] Close via click-outside works
- [ ] Reply input visible when authenticated
- [ ] Large threads (10+) scrollable
