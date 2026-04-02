# Klondike Solitaire

## Overview
A single-file browser-based Klondike Solitaire card game. No server-side logic — everything runs in the browser. The entire game (HTML, CSS, JavaScript) lives in one `index.html` file, served by a minimal Node.js static server.

## Tech Stack
- **Runtime**: Modern browser (Chrome, Firefox, Safari iOS 15+)
- **Language**: Vanilla HTML5, CSS3, ES6+ JavaScript
- **Framework**: None (REQ-17: no frameworks or build tools)
- **Serving**: node:22-slim Docker image with minimal static server
- **Persistence**: localStorage (high score only)

## Directory Structure
```
/
├── CLAUDE.md              # This file — AI agent instructions
├── index.html             # The complete game (created in Phase 2)
├── server.js              # Minimal Node.js static file server (port 8080)
├── Dockerfile             # node:22-slim, runs server.js
├── package.json           # Project metadata and convenience scripts
├── tsconfig.json          # Editor-only type checking (noEmit)
└── docs/
    ├── target/            # Specification documents
    │   ├── requirements.md
    │   ├── architecture.md
    │   ├── api.md
    │   ├── ui.md
    │   ├── data-model.md
    │   ├── tech-stack.md
    │   └── _tree.md
    └── implemented/       # Implementation tracking
        └── _tree.md
```

## Build & Run
```bash
# Local development
npm start

# Docker build and run
npm run docker:build
npm run docker:run
# Then open http://localhost:8080
```

> The container runs as non-root (`USER node`) on port 8080, with a `/healthz` endpoint for K8s probes.

## Conventions
- **Single file**: All game code (HTML, CSS, JS) in `index.html` — no external files
- **No external dependencies**: No CDN links, no npm runtime deps, no frameworks
- **CSS-only card rendering**: Cards drawn with CSS (suit symbols as text content), no image assets
- **Client-side state**: All game state in JavaScript; high score persisted to localStorage
- **`data-testid` attributes**: All interactive elements must have `data-testid` for automated testing
- **CSS custom properties**: Use `var(--name, fallback)` for theming — no hardcoded hex/rgba
- **rem units**: Use rem for sizing (except 1px borders)
- **No console.log**: Use structured comments or remove debug output before committing

## Key Design Decisions
1. **Single-file architecture** (REQ-17): Simplifies deployment, no build step, instant load
2. **localStorage for high score**: Minimal persistence, no server needed
3. **Fisher-Yates shuffle**: Unbiased card shuffling algorithm
4. **CSS custom properties for theming**: Green felt background, easy to customize
5. **Event delegation**: Single event listener on game container, dispatch by `data-action`
6. **Single-level undo**: Only the last move is stored; one undo per move
