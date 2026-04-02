# UI Specification

## Page Layout

```
┌─────────────────────────────────────────────────────┐
│  Header: Title | Moves: 0 | Best: -- | [New] [Undo] │
├─────────────────────────────────────────────────────┤
│                                                     │
│  [Stock] [Waste]          [F1] [F2] [F3] [F4]      │
│                                                     │
│  [T1] [T2] [T3] [T4] [T5] [T6] [T7]               │
│   |    |    |    |    |    |    |                    │
│   |    |    |    |    |    |    |                    │
│   |    |    |    |    |    |                         │
│   |    |    |    |    |                              │
│   |    |    |    |                                   │
│   |    |    |                                        │
│   |    |                                             │
│                                                     │
└─────────────────────────────────────────────────────┘
```

## Header
- **Title**: "Klondike Solitaire" (left-aligned)
- **Move counter**: "Moves: {n}" — updates on each valid move
- **High score**: "Best: {n}" or "Best: --" if no high score
- **New Game button**: Starts a fresh game
- **Undo button**: Reverts last move (disabled when no undo history)

## Card Component

### Face (face-up)
- White background with rounded corners (0.5rem border-radius)
- Subtle box shadow
- Top-left and bottom-right corners show: value + suit symbol
- Center area shows large suit symbol
- **Red suits** (♥♦): `var(--card-red, #d32f2f)`
- **Black suits** (♠♣): `var(--card-black, #1a1a1a)`
- Size: `4.5rem × 6.5rem` (desktop)

### Back (face-down)
- Distinct back pattern using CSS gradients
- Color: `var(--card-back, #1565c0)`
- Same dimensions as face

### Values Display
| Value | Display |
|-------|---------|
| 1 | A |
| 2-10 | 2-10 |
| 11 | J |
| 12 | Q |
| 13 | K |

## Pile Layout

### Stock Pile
- Top-left corner of game area
- Shows top card face-down (or empty indicator when depleted)
- Click draws to waste
- Empty state: dashed border circle (recycle indicator)
- `data-testid="pile-stock"`

### Waste Pile
- Adjacent to stock (right)
- Shows top card face-up
- Top card is draggable / clickable
- `data-testid="pile-waste"`

### Foundation Piles
- Top-right area, 4 piles in a row
- Empty state: suit symbol watermark (♠♥♦♣)
- Cards stack directly on top (no offset)
- `data-testid="pile-foundation-0"` through `data-testid="pile-foundation-3"`

### Tableau Columns
- 7 columns below the stock/foundation row
- Face-down cards: stacked with small vertical offset (0.5rem)
- Face-up cards: stacked with larger vertical offset (1.5rem) to show values
- `data-testid="pile-tableau-0"` through `data-testid="pile-tableau-6"`

## Interaction Flows

### Drag and Drop
1. Mouse down on a face-up card → card (and any cards on top) lifts, follows cursor
2. Drag over valid target → target pile highlights with `var(--drop-highlight, rgba(76, 175, 80, 0.3))`
3. Drop on valid target → cards move to destination, state updates
4. Drop on invalid target or empty space → cards animate back to source

### Click to Move
1. Click a face-up card (not drag)
2. Engine finds first valid destination: foundations first, then tableau left-to-right
3. Card moves to destination with brief transition animation
4. If no valid destination, card briefly shakes

### Stock Click
1. Click stock pile → top card flips to waste
2. Click empty stock → all waste cards return to stock (reversed, face-down)

### Keyboard Navigation
- **Tab**: Move focus between piles (stock → waste → foundations → tableau, left-to-right)
- **Arrow Up/Down**: Select card within a tableau column
- **Enter/Space**: Pick up selected card, then Enter/Space on target pile to place
- **Escape**: Cancel current selection
- Focus indicator: `var(--focus-ring, 0 0 0 3px #2196f3)` outline on focused pile

## Responsive Design

### Desktop (≥1024px)
- Full layout as described above
- Card size: `4.5rem × 6.5rem`
- Game area max-width: `60rem`, centered

### Tablet (768px–1023px)
- Same layout, scaled down
- Card size: `3.5rem × 5rem`
- Reduced pile spacing

### Below 768px
- Not a target (per assumptions), but game remains functional with horizontal scroll

## Win Screen
- Semi-transparent dark overlay covers game area
- Centered card with:
  - "You Win!" heading
  - "Completed in {n} moves" text
  - "New Best!" badge if high score beaten
  - "Play Again" button
- Confetti animation: CSS keyframe particles falling from top
- `data-testid="win-overlay"`
- `data-testid="win-play-again"`

## Background
- Game area background: `var(--felt-color, #2e7d32)` with subtle radial gradient for depth
- Body background: `var(--page-bg, #1b5e20)`

## CSS Custom Properties (Theme)
```css
:root {
  --felt-color: #2e7d32;
  --page-bg: #1b5e20;
  --card-red: #d32f2f;
  --card-black: #1a1a1a;
  --card-bg: #ffffff;
  --card-back: #1565c0;
  --card-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
  --card-width: 4.5rem;
  --card-height: 6.5rem;
  --drop-highlight: rgba(76, 175, 80, 0.3);
  --focus-ring: 0 0 0 3px #2196f3;
  --header-bg: #1b5e20;
  --header-text: #ffffff;
  --button-bg: #4caf50;
  --button-text: #ffffff;
}
```

## data-testid Reference

| Element | data-testid |
|---------|------------|
| Stock pile | `pile-stock` |
| Waste pile | `pile-waste` |
| Foundation pile N | `pile-foundation-{0-3}` |
| Tableau column N | `pile-tableau-{0-6}` |
| Individual card | `card-{suit}-{value}` (e.g. `card-hearts-1`) |
| New Game button | `btn-new-game` |
| Undo button | `btn-undo` |
| Move counter | `display-moves` |
| High score | `display-highscore` |
| Win overlay | `win-overlay` |
| Play Again button | `win-play-again` |
| Win move count | `win-move-count` |
