Refactored username to be passed as an argument in NixOS and Home Manager configurations to improve DRYness.

## Waybar Integration
- Added `custom/notification` module for SwayNC integration.
- Configured icons for notification states (dnd, inhibited, etc).
- Added styling for `#custom-notification` to match existing modules (17px font size, margin).

## SwayNC Integration
- SwayNC configuration and styles are located in `modules/home-manager/swaync/`.
- The service is enabled in `home-manager/home.nix` using `services.swaync.enable = true;`.
- Configuration files are symlinked to `~/.config/swaync/` via `xdg.configFile` in `home-manager/symlinks.nix`.
- Using `xdg.configFile."swaync".source = ../modules/home-manager/swaync;` allows managing the entire configuration directory as a single unit.

### Nix Warnings
- Fixed 'system' rename warning by using 'hostPlatform' in 'nixpkgs' import and 'pkgs.stdenv.hostPlatform.system' instead of 'pkgs.system' in modules.
- 'xorg.libxcb' was not found in the codebase; verified that 'nix flake check' no longer produces evaluation warnings related to 'system'.
