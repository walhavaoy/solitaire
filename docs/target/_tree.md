# Component Taxonomy

## Component Priority Matrix

| Component | Phase | Priority | Dependencies | Complexity | Description |
|-----------|-------|----------|-------------|------------|-------------|
| **GameEngine.init** | 1 | P0 | None | Medium | Deck creation, Fisher-Yates shuffle, tableau dealing |
| **GameEngine.validate** | 1 | P0 | GameEngine.init | High | Move validation (tableau rules, foundation rules, stock/waste) |
| **GameEngine.state** | 1 | P0 | GameEngine.init | Medium | State management, move execution, undo stack |
| **Renderer.layout** | 2 | P0 | None | Medium | Initial DOM structure (piles, header, game area) |
| **Renderer.cards** | 2 | P0 | Renderer.layout | Medium | Card face/back rendering with CSS (suits, values, colors) |
| **Renderer.update** | 2 | P0 | Renderer.layout, GameEngine.state | Medium | DOM updates on state change (card positions, counters) |
| **InteractionLayer.drag** | 2 | P0 | Renderer.cards, GameEngine.validate | High | Drag-and-drop card movement |
| **InteractionLayer.click** | 2 | P1 | GameEngine.validate | Low | Click-to-move and stock click |
| **InteractionLayer.keyboard** | 3 | P2 | Renderer.layout | Medium | Keyboard navigation (Tab, Arrow, Enter, Space) |
| **StorageManager** | 3 | P1 | GameEngine.state | Low | localStorage read/write for high score |
| **WinDetection** | 3 | P0 | GameEngine.state | Low | Win condition check, trigger win screen |
| **WinScreen** | 3 | P2 | Renderer.layout, WinDetection | Medium | Overlay with confetti animation, play-again |
| **Undo** | 3 | P1 | GameEngine.state | Medium | Undo stack management and state reversal |
| **AutoComplete** | 4 | P2 | GameEngine.validate | Medium | Auto-move remaining cards to foundations |
| **Responsive** | 4 | P1 | Renderer.layout | Low | Tablet breakpoint, scaled cards |
| **Polish** | 4 | P2 | All | Low | Transitions, animations, empty-pile indicators |
| **Docker** | 1 | P0 | None | Low | Dockerfile for nginx:alpine deployment |

## Phase Summary

### Phase 1: Core Engine + Infrastructure
- GameEngine (init, validate, state)
- Dockerfile
- **Deliverable**: Working game logic with no UI

### Phase 2: Rendering + Primary Interaction
- Renderer (layout, cards, update)
- InteractionLayer (drag, click)
- **Deliverable**: Playable game with mouse interaction

### Phase 3: Features + Win Condition
- Keyboard navigation
- Storage (high score)
- Win detection + win screen
- Undo
- **Deliverable**: Feature-complete game

### Phase 4: Polish + Responsiveness
- Auto-complete
- Responsive tablet layout
- Transitions, animations, visual polish
- **Deliverable**: Production-ready game
