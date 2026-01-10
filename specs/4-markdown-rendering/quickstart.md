# Quickstart: Markdown Rendering with Sanitization

**Feature**: 4-markdown-rendering  
**Date**: 2026-01-10

## Prerequisites

- Completed Spec 1-3
- CDN access for libraries

## Implementation Steps

1. **Add CDN links to index.html**:

   ```html
   <!-- In <head> -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/highlight.js/styles/github.min.css">
   
   <!-- Before app.js -->
   <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/dompurify/dist/purify.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/highlight.js/lib/core.min.js"></script>
   ```

2. **Configure marked.js** in app.js:
   - Enable GFM mode
   - Add custom link renderer for `target="_blank"`
   - Integrate highlight.js for code blocks

3. **Add rendering function**:
   - Parse Markdown with marked
   - Sanitize with DOMPurify
   - Insert into DOM

4. **Add CSS for Markdown content**:
   - Code block styling
   - Table styling
   - Image max-width
   - Heading hierarchy

## Test Content

Create a test Gist with this content:

```markdown
# Heading 1
## Heading 2

**Bold** and *italic* text.

- Bullet list
- Item 2

1. Numbered list
2. Item 2

[External link](https://example.com)

`inline code`

​```javascript
function hello() {
  console.log("Hello, World!");
}
​```

| Table | Header |
|-------|--------|
| Cell  | Data   |

<script>alert('XSS')</script>
<img src="x" onerror="alert('XSS')">
```

## Security Testing

Test these XSS payloads (all should be neutralized):

1. `<script>alert('XSS')</script>`
2. `<img src="x" onerror="alert('XSS')">`
3. `<a href="javascript:alert('XSS')">Click</a>`
4. `<svg onload="alert('XSS')">`

## Verification Steps

1. Load Gist with test content
2. Verify all Markdown elements render correctly
3. Verify code blocks have syntax highlighting
4. Verify XSS payloads are neutralized (check console)
5. Verify external links open in new tab
6. Verify images are constrained to container width

## Success Criteria Checklist

- [ ] Headings, lists, links, emphasis render correctly
- [ ] Code blocks have syntax highlighting
- [ ] Tables render with proper styling
- [ ] No JavaScript executes from content
- [ ] No browser security warnings
- [ ] Renders within 1 second of receiving content
