# Plan: SwayNC Integration & Flake Overhaul

## TL;DR

> **Quick Summary**: We will overhaul the flake to use pure unstable `nixpkgs`, deduplicate dependencies, fix warnings, and integrate SwayNC with Waybar matching your `vicinae-dark` theme.
> 
> **Deliverables**:
> - Optimized `flake.nix` & `flake.lock` (pure unstable + follows)
> - Refactored config using `specialArgs` for username (DRY)
> - Fully configured SwayNC service matching Waybar colors
> - Waybar integration (toggle button for notifications)
> - Warning-free evaluation
> 
> **Estimated Effort**: Medium
> **Parallel Execution**: YES - 2 waves
> **Critical Path**: Flake Refactor → DRY Refactor → SwayNC Setup → Waybar Integration

---

## Context

### Original Request
"rate my nix flake please" → "use swaync but with config that follows the same colors and ui of the waybar. also integrate it in waybar without braking my waybar system and style. plan this"

### Interview Summary
**Key Discussions**:
- **Flake Issues**: Identified 8 duplicated `nixpkgs` versions and hardcoded username values.
- **Notification Fix**: Replaced missing daemon with SwayNC.
- **Style Requirement**: SwayNC must match Waybar colors (from `colors.css`) and integrate seamlessly.
- **Waybar Integration**: Add a toggle button to the existing Waybar config without breaking layout.

**Research Findings**:
- **Existing Config**: `modules/home-manager/waybar/` contains `config.jsonc`, `style.css`, and `colors.css`.
- **Colors**: Defined in `colors.css` (Background: `#030712`, Foreground: `#f3f4f6`, Accent: `#ff637e`).
- **Missing Service**: `services.swaync` is not currently enabled.

---

## Work Objectives

### Core Objective
Modernize the flake architecture and implement a cohesive notification system (SwayNC) that integrates visually and functionally with the existing desktop environment.

### Concrete Deliverables
- `flake.nix`: Pure unstable + follows pattern
- `flake.lock`: Deduplicated
- `modules/home-manager/swaync/config.json`: Configuration
- `modules/home-manager/swaync/style.css`: Themed styling
- `modules/home-manager/waybar/config.jsonc`: Added notification module
- `modules/home-manager/waybar/style.css`: Styling for notification module
- `modules/home-manager/programs.nix`: Enabled `services.swaync`

### Definition of Done
- [x] `nix flake check` passes without warnings
- [x] `flake.lock` contains only ONE `nixpkgs` version
- [x] `home-manager switch` completes successfully
- [x] Waybar shows notification icon (bell)
- [x] Clicking icon opens SwayNC panel
- [x] SwayNC panel matches Waybar colors exactly

### Must Have
- Pure `nixos-unstable` input (no mixed stable/unstable)
- `inputs.*.follows = "nixpkgs"` for all inputs
- `username` passed via `specialArgs` (DRY)
- SwayNC matching `#030712` background

### Must NOT Have (Guardrails)
- Hardcoded usernames in modules
- Manual `pkgs` import in `flake.nix` (unifying config)
- Broken Waybar layout (toggle must fit naturally)

---

## Verification Strategy

> **UNIVERSAL RULE: ZERO HUMAN INTERVENTION**
> ALL tasks in this plan MUST be verifiable WITHOUT any human action.

### Test Decision
- **Infrastructure exists**: NO
- **Automated tests**: NO (UI/Config focus)
- **Agent-Executed QA**: YES (Mandatory)

### Agent-Executed QA Scenarios

**Scenario: Flake Evaluation**
  Tool: Bash
  Steps:
    1. `nix flake check`
    2. `nix eval .#nixosConfigurations.nixos.config.system.build.toplevel.outPath`
  Expected Result: Success, no warnings about 'system' or 'xorg'

**Scenario: Dependency Deduplication**
  Tool: Bash
  Steps:
    1. `grep "nixpkgs_" flake.lock | wc -l`
  Expected Result: Output is "0" (or close to 0 if some inputs force own nixpkgs, but aim for 0 duplicates)

**Scenario: SwayNC Service Check**
  Tool: Bash
  Steps:
    1. `grep "services.swaync.enable = true" modules/home-manager/programs.nix`
  Expected Result: Found

**Scenario: Waybar Config Check**
  Tool: Bash
  Steps:
    1. `grep "custom/notification" modules/home-manager/waybar/config.jsonc`
  Expected Result: Found

---

## Execution Strategy

### Parallel Execution Waves

```
Wave 1 (Cleanup & Setup):
├── Task 1: Flake Refactor (Unstable + Follows)
├── Task 2: DRY Refactor (Username)
└── Task 3: SwayNC Config & Style Creation

Wave 2 (Integration):
├── Task 4: Enable SwayNC Service
├── Task 5: Waybar Integration (Module & Style)
└── Task 6: Fix Warnings
```

---

## TODOs

- [x] 1. Flake Refactor: Pure Unstable & Deduplication

  **What to do**:
  - Update `flake.nix`:
    - Remove `nixpkgs-unstable`, point `nixpkgs` to `nixos-unstable`.
    - Add `inputs.<name>.inputs.nixpkgs.follows = "nixpkgs"` to ALL inputs.
    - Remove manual `pkgs` import in `outputs`.
  - Update `flake.lock`: Run `nix flake update`.

  **Must NOT do**:
  - Break existing inputs (ensure URLs remain correct).

  **Recommended Agent Profile**:
  - **Category**: `quick`
  - **Skills**: [`git-master`]

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1

  **Acceptance Criteria**:
  - [ ] `grep "nixpkgs_" flake.lock` returns 0 (or significantly reduced)
  - [ ] `nix flake check` passes

- [x] 2. DRY Refactor: Username & Args

  **What to do**:
  - Update `nixos/configuration.nix` and `home-manager/home.nix` to accept `{ username, ... }` in args.
  - Replace hardcoded `"samouly"` with `${username}`.
  - Ensure `flake.nix` passes `specialArgs` correctly (already doing so, just verify).

  **Recommended Agent Profile**:
  - **Category**: `quick`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1

  **Acceptance Criteria**:
  - [ ] `grep "samouly" home-manager/home.nix` returns 0 (except maybe comments)

- [x] 3. Create SwayNC Config & Style

  **What to do**:
  - Create `modules/home-manager/swaync/config.json`: Standard config.
  - Create `modules/home-manager/swaync/style.css`:
    - Import/Use colors from Waybar's `colors.css` (or duplicate definitions if import not supported by SwayNC css).
    - Match `waybar` font ("ComicShannsMono Nerd Font Mono").
    - Background: `#030712`, Text: `#f3f4f6`, Border: `#ff637e` (if any).

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`
  - **Skills**: [`frontend-ui-ux`]

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1

  **Acceptance Criteria**:
  - [ ] Files exist in `modules/home-manager/swaync/`
  - [ ] Style matches hex codes from `colors.css`

- [x] 4. Enable SwayNC Service

  **What to do**:
  - Edit `modules/home-manager/programs.nix` (or `vicinae.nix`):
    - Add `services.swaync.enable = true;`.
    - Ensure `programs.nix` returns `{ imports = [ ... ]; options = ...; config = ...; }` structure if adding top-level config, OR just add to existing `home.packages` if service module not available (but `services.swaync` is standard in HM).
    - Actually `services.swaync` is a valid HM module. Add it to `config` section or top level.

  **Recommended Agent Profile**:
  - **Category**: `quick`

  **Parallelization**:
  - **Can Run In Parallel**: NO (Depends on Wave 1 structure)
  - **Parallel Group**: Wave 2

  **Acceptance Criteria**:
  - [ ] `nix eval .#homeConfigurations.samouly.config.services.swaync.enable` returns true

- [x] 5. Waybar Integration

  **What to do**:
  - Edit `modules/home-manager/waybar/config.jsonc`:
    - Add `custom/notification` module.
    - Config:
      ```json
      "custom/notification": {
        "tooltip": false,
        "format": "{icon}",
        "format-icons": {
          "notification": "<span foreground='red'><sup></sup></span>",
          "none": "",
          "dnd-notification": "<span foreground='red'><sup></sup></span>",
          "dnd-none": "",
          "inhibited-notification": "<span foreground='red'><sup></sup></span>",
          "inhibited-none": "",
          "dnd-inhibited-notification": "<span foreground='red'><sup></sup></span>",
          "dnd-inhibited-none": ""
        },
        "return-type": "json",
        "exec-if": "which swaync-client",
        "exec": "swaync-client -swb",
        "on-click": "swaync-client -t -sw",
        "on-click-right": "swaync-client -d -sw",
        "escape": true
      }
      ```
    - Add `"custom/notification"` to `modules-right` (last item).
  - Edit `modules/home-manager/waybar/style.css`:
    - Add `#custom-notification { ... }` styling (margin, padding, font size) matching other icons.

  **Recommended Agent Profile**:
  - **Category**: `visual-engineering`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2

  **Acceptance Criteria**:
  - [ ] `custom/notification` present in `config.jsonc`
  - [ ] Style rule exists in `style.css`

- [x] 6. Fix Warnings

  **What to do**:
  - Remove explicit `system` arg passed to `nixpkgs.lib.nixosSystem` if it causes warning (or use `nixpkgs.lib.nixosSystem { system = ... }` correctly).
  - Check `nixos/configuration.nix` for `xorg.libxcb` usage and replace with `libxcb` or remove if unused.

  **Recommended Agent Profile**:
  - **Category**: `quick`

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 2

  **Acceptance Criteria**:
  - [ ] `nix flake check` is warning-free

---

## Success Criteria

### Verification Commands
```bash
nix flake check
nix eval .#nixosConfigurations.nixos.config.system.build.toplevel.outPath
grep "services.swaync.enable" modules/home-manager/programs.nix
```

### Final Checklist
- [x] Flake is pure unstable (no mixed inputs)
- [x] Dependencies deduplicated (minimal `nixpkgs` copies)
- [x] Username is dynamic (DRY)
- [x] SwayNC service enabled and configured
- [x] Waybar has notification toggle
- [x] Visual style is consistent (Dark theme)
