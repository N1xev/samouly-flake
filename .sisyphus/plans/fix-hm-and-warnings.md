# Plan: Fix Home Manager Error and NixOS Warnings

## Context
- **Issue 1**: `hms` fails with `error: attribute 'currentSystem' missing`. This is an impure evaluation error in a pure flake context.
- **Issue 2**: `nrs` shows warnings about deprecated `xorg` package names (`xorg.libxcb` -> `libxcb`, etc.).

## Diagnosis
1.  **HM Error**: The error `currentSystem` usually happens when `nixpkgs` is imported without a `system` argument. Passing `pkgs` to `homeManagerConfiguration` while also having `nixpkgs.overlays` or `nixpkgs.config` in modules can trigger a re-evaluation of `nixpkgs` which lacks the context of the flake.
2.  **xorg Warnings**: These are likely in a package wrapper or a module that I haven't fully scrubbed. Since `grep` missed them, they might be accessed via `pkgs.xorg.*`.

## Proposed Fixes
1.  **Unify nixpkgs Configuration**:
    - Move overlays and allowUnfree/permittedInsecurePackages from modules (`home.nix`, `configuration.nix`) into the main `pkgs` instantiation in `flake.nix`.
    - Pass this unified `pkgs` to both NixOS and Home Manager.
    - Ensure `system` is passed to `homeManagerConfiguration`.
2.  **Scrub xorg references**:
    - Even if `grep` missed them, I will perform a systematic check and replacement of common deprecated `xorg` attributes with their top-level counterparts.

## TODOs
- [x] 1. Move overlays from `home-manager/home.nix` to `flake.nix`.
- [x] 2. Consolidate `allowUnfree` and `permittedInsecurePackages` in `flake.nix`.
- [x] 3. Update `homeManagerConfiguration` to include `system` and use unified `pkgs`.
- [x] 4. Remove `nixpkgs` config/overlays from `home.nix` and `configuration.nix`.
- [x] 5. Search and replace deprecated `xorg.*` references.
- [x] 6. Investigate and resolve undefined 'opencode' package reference

## Execution
I will delegate these tasks to specialized agents.
