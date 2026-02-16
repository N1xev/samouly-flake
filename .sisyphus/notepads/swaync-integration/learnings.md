
## SwayNC Theme Refinement (Flat & Direct)
- Refined `modules/home-manager/swaync/style.css` to fully embrace the "flat" aesthetic.
- **Notifications**:
  - All priorities (`low`, `normal`, `critical`) now share the same `@bg` background.
  - Priority is indicated *solely* by `border-left-color`.
  - `.low` uses `#6b7280` (gray), `.normal` uses `@accent`, `.critical` uses `@warning`.
- **Widget Buttons**:
  - Moved away from container-based styling to **direct button styling**.
  - Selectors now target `button` elements directly (e.g., `.widget-buttons-grid button`) instead of nested `flowbox` structures.
  - Wrapper containers (like `.widget-mpris-player`) set to `background: transparent` to avoid "awkward box" look.
  - Consistent hover states: `@accent` background with `@bg` text.
