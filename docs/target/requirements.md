# Requirements

All requirements use `REQ-{area}-{nn}` format for Maestro task tracking.
Areas: `GL` (game logic), `IN` (interaction), `SC` (scoring), `UI` (user interface), `IF` (infrastructure).

## Game Logic

- REQ-GL-01: Standard 52-card Klondike deal — 7 tableau columns (1-7 cards, top face-up), stock pile, waste pile, 4 foundation piles (Ace to King by suit)
- REQ-GL-02: Card movement validation — tableau-to-tableau (descending rank, alternating color), waste-to-tableau, waste/tableau-to-foundation; invalid moves rejected silently
- REQ-GL-03: Stock and waste piles — click stock to draw one card to waste; click empty stock to recycle waste back face-down and reversed
- REQ-GL-04: Auto-flip tableau card when revealed — face-down card with no cards above it flips automatically
- REQ-GL-05: Win detection — all 52 cards in foundation piles triggers win state
- REQ-GL-06: Fisher-Yates shuffle for unbiased random deck on new game

## Interaction

- REQ-IN-01: Drag and drop for moving single cards and face-up stacks between all piles (tableau, waste, foundation)
- REQ-IN-02: Click-to-move — click a card to auto-move it to the best valid destination (foundation first, then tableau)
- REQ-IN-03: Keyboard navigation — Tab between piles, Arrow keys within pile, Enter/Space to select and place, Escape to cancel
- REQ-IN-04: Undo last move — single-level undo reverting the previous move (not the New Game action)
- REQ-IN-05: New Game button — full game reset, fresh shuffle, new deal, move counter reset

## Scoring

- REQ-SC-01: Live move counter displayed during gameplay — increments on each valid card move, resets on New Game
- REQ-SC-02: Persistent high score (lowest winning move count) stored in localStorage under key `klondike-highscore`

## User Interface

- REQ-UI-01: CSS-only card rendering — card faces with suit symbols (♥ ♦ ♣ ♠), rank text, alternating red/black colors; no external image assets
- REQ-UI-02: Green felt card-table aesthetic — felt background color, card shadows, classic warm palette
- REQ-UI-03: Win animation — confetti or celebration overlay displaying final move count and Play Again button
- REQ-UI-04: data-testid attributes on all interactive elements using format `solitaire-{element}`
- REQ-UI-05: Responsive layout for desktop and tablet viewports (Chrome, Firefox, Safari iOS 15+)

## Infrastructure

- REQ-IF-01: Single index.html file — all HTML, CSS, and JS embedded; no external dependencies, no build step, no CDN links
- REQ-IF-02: Dockerfile using nginx:alpine, copying index.html to /usr/share/nginx/html/, serving on port 80

## Assumptions

1. Draw-one variant only (not draw-three)
2. No timer — scoring by move count only
3. No save/resume of in-progress games — only high score persists
4. Desktop and tablet targets — no phone layout required
5. No sound effects or multiplayer
