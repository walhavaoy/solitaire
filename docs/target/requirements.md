# Requirements

## Game Logic

### REQ-01: Standard Klondike Rules
- **Type**: Functional
- **Priority**: P0
- **Description**: Implement standard Klondike Solitaire rules — 52-card deck, 7 tableau columns (1-7 cards, top face-up), stock pile, waste pile, 4 foundation piles (Ace to King by suit).
- **Acceptance Criteria**: Game initializes with correct tableau layout; only valid moves are permitted; foundations accept cards in ascending order by suit starting from Ace.

### REQ-02: Card Movement Validation
- **Type**: Functional
- **Priority**: P0
- **Description**: Validate all card moves — tableau-to-tableau (descending rank, alternating color), tableau-to-foundation, waste-to-tableau, waste-to-foundation. Reject invalid moves.
- **Acceptance Criteria**: Invalid moves are rejected silently (card snaps back). Valid moves update game state and re-render.

### REQ-03: Stock and Waste Piles
- **Type**: Functional
- **Priority**: P0
- **Description**: Click stock to draw one card to waste. When stock is empty, click to recycle waste back to stock (face-down, reversed order).
- **Acceptance Criteria**: Drawing from stock moves top card face-up to waste. Recycling flips all waste cards back to stock. Visual indicator when stock is empty.

### REQ-04: Auto-Flip Tableau Cards
- **Type**: Functional
- **Priority**: P0
- **Description**: When a face-down tableau card is revealed (no cards above it), automatically flip it face-up.
- **Acceptance Criteria**: Face-down cards flip immediately after the covering card is moved away.

### REQ-05: Win Detection
- **Type**: Functional
- **Priority**: P0
- **Description**: Detect win condition — all 52 cards in foundation piles.
- **Acceptance Criteria**: Win screen displays when all foundations have 13 cards each.

### REQ-06: Fisher-Yates Shuffle
- **Type**: Functional
- **Priority**: P1
- **Description**: Use Fisher-Yates algorithm for unbiased deck shuffling on new game.
- **Acceptance Criteria**: Each new game produces a different, uniformly random card arrangement.

### REQ-07: Move Counter
- **Type**: Functional
- **Priority**: P1
- **Description**: Track and display the number of moves made in the current game.
- **Acceptance Criteria**: Counter increments on each valid move. Displayed in header. Resets on new game.

### REQ-08: High Score (Best Moves)
- **Type**: Functional
- **Priority**: P1
- **Description**: Track lowest move count to win. Persist to localStorage.
- **Acceptance Criteria**: High score updates when player wins with fewer moves than current best. Persists across page reloads. Key: `klondike-highscore`, value: JSON `{"bestScore": <number>}`.

## Interaction

### REQ-09: Drag and Drop
- **Type**: Functional
- **Priority**: P0
- **Description**: Cards can be dragged from source pile and dropped on valid target pile. Stacks of face-up tableau cards can be dragged as a group.
- **Acceptance Criteria**: Drag shows card(s) following cursor. Drop on valid target moves card(s). Drop on invalid target returns card(s) to source.

### REQ-10: Click to Move
- **Type**: Functional
- **Priority**: P1
- **Description**: Single click on a card auto-moves it to the first valid destination (foundation preferred, then tableau).
- **Acceptance Criteria**: Click on a movable card moves it to the best valid target without requiring drag.

### REQ-11: Keyboard Navigation
- **Type**: Functional
- **Priority**: P2
- **Description**: Navigate between piles with Tab, within piles with Arrow keys, select/place with Enter or Space.
- **Acceptance Criteria**: All game actions achievable via keyboard alone. Focus indicator visible on selected pile/card.

### REQ-12: Undo
- **Type**: Functional
- **Priority**: P1
- **Description**: Undo button reverts the last move. Full undo history (no limit).
- **Acceptance Criteria**: Each click of Undo reverts one move, restoring previous state. Undo is disabled when no moves to undo.

### REQ-13: New Game
- **Type**: Functional
- **Priority**: P0
- **Description**: New Game button reshuffles the deck and resets the board.
- **Acceptance Criteria**: Clicking New Game starts a fresh game with a new shuffle. Move counter resets.

## UI/UX

### REQ-14: Card Rendering with CSS
- **Type**: Non-functional
- **Priority**: P0
- **Description**: Render cards using CSS only — suit symbols as text (♠♥♦♣), colored red/black, card shape with border radius and shadow. No image assets.
- **Acceptance Criteria**: Cards are visually recognizable with suit, value, and color. Card backs have a distinct pattern.

### REQ-15: Green Felt Background
- **Type**: Non-functional
- **Priority**: P1
- **Description**: Game area has a green felt-textured background using CSS.
- **Acceptance Criteria**: Background is green with subtle texture (CSS gradient or pattern). Defined via CSS custom property `--felt-color`.

### REQ-16: Win Animation
- **Type**: Non-functional
- **Priority**: P2
- **Description**: Display a celebratory animation on win — confetti effect using CSS animations, move count, and play-again button.
- **Acceptance Criteria**: Win overlay appears with animation. Shows final move count. Play Again button starts a new game.

## Infrastructure

### REQ-17: Single-File Architecture
- **Type**: Non-functional
- **Priority**: P0
- **Description**: The entire game must be contained in a single `index.html` file. No external dependencies, no build step, no framework.
- **Acceptance Criteria**: Opening `index.html` directly in a browser runs the complete game. No network requests required (except initial page load when served).

### REQ-18: Docker Deployment
- **Type**: Non-functional
- **Priority**: P0
- **Description**: Dockerfile using nginx:alpine serves `index.html` on port 80.
- **Acceptance Criteria**: `docker build` succeeds. `docker run -p 80:80` serves the game. Container is under 50MB.

## Assumptions
1. Draw-one variant only (not draw-three)
2. No timer — scoring is by move count only
3. No save/resume of in-progress games — only high score persists
4. Desktop and tablet targets — no phone-optimized layout required
5. No sound effects
6. No multiplayer or online features
7. Accessibility limited to keyboard navigation (REQ-11), no screen reader optimization
