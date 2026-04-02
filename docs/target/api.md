# API Contracts

## Overview
This project has no REST API or server-side endpoints. This document defines the internal JavaScript API surface, localStorage contracts, and the GameState interface used for state management.

## Public JavaScript Functions

### Game Control
| Function | Parameters | Returns | Description |
|----------|-----------|---------|-------------|
| `newGame()` | none | `void` | Shuffles deck, deals tableau, resets move counter, clears undo stack |
| `drawFromStock()` | none | `void` | Moves top stock card to waste (face-up). If stock empty, recycles waste to stock |
| `moveCard(from, to)` | `from: PileId, to: PileId` | `boolean` | Attempts to move the top card from source to destination. Returns true if valid |
| `moveStack(from, to, count)` | `from: PileId, to: PileId, count: number` | `boolean` | Moves `count` face-up cards from source tableau to destination tableau |
| `undo()` | none | `void` | Reverts the last move. No-op if undo stack is empty |
| `autoComplete()` | none | `void` | If all cards are face-up, automatically moves cards to foundations |

### Query Functions
| Function | Parameters | Returns | Description |
|----------|-----------|---------|-------------|
| `getGameState()` | none | `GameState` | Returns current game state (read-only snapshot) |
| `canAutoComplete()` | none | `boolean` | Returns true if all tableau cards are face-up |
| `isGameWon()` | none | `boolean` | Returns true if all foundations are complete |
| `getHighScore()` | none | `number \| null` | Returns best move count from localStorage, or null if none |

## PileId Format
Pile identifiers are strings:
- `"stock"` — the stock pile
- `"waste"` — the waste pile
- `"foundation-0"` through `"foundation-3"` — foundation piles (hearts, diamonds, clubs, spades)
- `"tableau-0"` through `"tableau-6"` — tableau columns (left to right)

## localStorage Contract

### Key: `klondike-highscore`
```json
{
  "bestScore": 87
}
```
- **bestScore** (`number`): Lowest move count to win. Updated only when the player wins with fewer moves than the current best.
- If key does not exist, no high score has been recorded.
- Read on page load; written on win if new record.

## GameState Interface
```typescript
interface GameState {
  tableau: Pile[];       // 7 tableau columns
  foundations: Pile[];   // 4 foundation piles
  stock: Pile;           // stock pile
  waste: Pile;           // waste pile
  moveCount: number;     // moves made this game
  undoStack: Move[];     // full undo history
  gameWon: boolean;      // true when all foundations complete
}

interface Pile {
  id: string;            // PileId
  type: "stock" | "waste" | "foundation" | "tableau";
  cards: Card[];         // ordered, index 0 = bottom
}

interface Card {
  suit: "hearts" | "diamonds" | "clubs" | "spades";
  value: number;         // 1 (Ace) through 13 (King)
  faceUp: boolean;
}

interface Move {
  type: "draw" | "move" | "recycle" | "flip";
  from: string;          // source PileId
  to: string;            // destination PileId
  cards: Card[];         // cards involved
  flippedCard?: Card;    // card that was auto-flipped after move
}
```
