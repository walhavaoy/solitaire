# Tech Stack

## Runtime
- **Platform**: Modern web browser
- **Target browsers**: Chrome (latest), Firefox (latest), Safari iOS 15+
- **JavaScript**: ES2020+ (const/let, arrow functions, template literals, optional chaining, destructuring)
- **HTML**: HTML5 semantic elements
- **CSS**: CSS3 with custom properties, flexbox, grid, keyframe animations

## Framework
**None** — this is a vanilla HTML/CSS/JS application per REQ-17. No React, Vue, Angular, or any other framework. No jQuery. No utility libraries.

## Build Toolchain
**None** — per REQ-17, there is no build step. The source `index.html` IS the artifact. No TypeScript compilation, no bundling, no minification, no preprocessing.

## Editor Tooling
- `tsconfig.json` is provided for IDE type checking only (`noEmit: true`, `checkJs: true`)
- This enables VS Code / editor IntelliSense for JSDoc-typed JavaScript
- It is NOT part of any build pipeline

## Package Management
- `package.json` exists for project metadata and convenience scripts only
- **Zero runtime dependencies** — no `dependencies` section
- Dev scripts: `start` (local dev server), `docker:build`, `docker:run`

## Serving & Deployment
- **Docker image**: `nginx:alpine`
- **Port**: 80
- **Content**: Single `index.html` copied to `/usr/share/nginx/html/`
- **Image size target**: Under 50MB (nginx:alpine base is ~40MB)

## Persistence
- **localStorage**: Browser-native key-value storage
- **Key**: `klondike-highscore`
- **Data**: JSON object with `bestScore` field
- **No database, no backend, no cookies, no session storage**

## Testing Strategy
- Manual testing in target browsers
- `data-testid` attributes on all interactive elements for potential automated testing
- No test framework included in initial scaffolding (may be added later if needed)

## Architecture Decision Records

| Decision | Choice | Rationale |
|----------|--------|-----------|
| Framework | None (vanilla) | REQ-17 mandates no frameworks; single-file constraint makes frameworks impractical |
| Card rendering | CSS-only | No image assets to load; CSS text is sufficient for suit symbols; keeps single-file constraint |
| Shuffle algorithm | Fisher-Yates | O(n) time, O(1) extra space, provably unbiased |
| State management | Plain objects | No framework = no need for reactive state; direct DOM manipulation on state change |
| Deployment | nginx:alpine | Minimal image for static file serving; well-understood, production-ready |
| Persistence | localStorage | Built-in browser API; no server needed; sufficient for high score |
