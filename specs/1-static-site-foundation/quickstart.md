# Quickstart: Static Site Foundation

**Feature**: 1-static-site-foundation  
**Date**: 2026-01-10

## Prerequisites

- Modern web browser (Chrome, Firefox, Safari, Edge)
- One of: Python 3.x OR Node.js/npm

## Local Development

### Option 1: Python HTTP Server

```bash
# Navigate to repository root
cd gist-review

# Start the server
python -m http.server 8000

# Open in browser
# http://localhost:8000
```

### Option 2: npx serve

```bash
# Navigate to repository root
cd gist-review

# Start the server (no global install needed)
npx serve

# Open the URL shown in terminal output
```

### Option 3: Direct File Access

Open `index.html` directly in a browser (some features may not work due to file:// protocol restrictions).

## Files to Create

1. **index.html** - Application shell with:
   - Header containing "Gist Review" title
   - Main content area (empty, ready for Gist content)
   - Footer with copyright notice

2. **styles.css** - Responsive styles with:
   - Mobile-first approach
   - Single breakpoint at 768px
   - Light/dark theme via `prefers-color-scheme`
   - Max-width 1200px for main content

3. **app.js** - Placeholder JavaScript file (initially empty or minimal)

## Verification Steps

1. Open application in browser
2. Verify header shows "Gist Review"
3. Verify footer shows copyright notice
4. Test responsive layout by resizing browser
5. Test dark mode by changing system preference
6. Verify page works without JavaScript (structure visible)

## Success Criteria Checklist

- [ ] Page loads in under 1 second
- [ ] Works with `python -m http.server`
- [ ] Works with `npx serve`
- [ ] Readable without JavaScript
- [ ] Usable on 320px - 1920px viewports
