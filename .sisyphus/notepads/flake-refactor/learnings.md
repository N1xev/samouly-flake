# Flake Refactor: Pure Unstable & Deduplication

## Learnings
- Consolidating nixpkgs inputs to a single name (e.g., `nixpkgs`) and using `.follows = "nixpkgs"` across all other inputs is highly effective for deduplicating the lockfile.
- Some flakes use different names for nixpkgs (e.g., `niri-flake` uses `nixpkgs-stable`). These must also be pointed to the main `nixpkgs` for full deduplication.
- `nixos-hardware` (master branch) does not seem to have a `nixpkgs` input, and overriding it results in a warning.
- `nix flake update` can fail due to transient network or remote tarball issues (e.g., "Truncated tar archive"). In such cases, updating individual inputs using `nix flake lock --update-input <name>` can be a successful workaround to apply lockfile changes.

