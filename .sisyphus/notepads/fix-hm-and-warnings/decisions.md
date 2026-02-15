# Decisions

## Opencode Package Reference
- **Problem**: User reported `opencode` as undefined in `nixos/configuration.nix` and `modules/home-manager/packages.nix`, causing build failure, though it existed in the agent's environment.
- **Decision**: Commented out the `opencode` references in both files.
- **Rationale**: To ensure the build works for the user who likely doesn't have this package in their `nixpkgs` or overlay. Added TODOs to investigate further.
