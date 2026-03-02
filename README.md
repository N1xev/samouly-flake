> [!CAUTION]
> this is my personal NixOS configuration with flakes and home-manager make sure to change packages that you dont need before installing it!

## Installation (Copy-Paste Method)

This is a **template** - copy the files you need and adjust to your system.

### Prerequisites

- NixOS with flakes enabled (or Nix installed on any Linux)
- Home-manager

### Quick Start

```bash
# 1. Copy the home-manager module
cp -r ~/flakey/modules/home-manager ~/.config/

# 2. Create your home.nix
cp ~/flakey/home-manager/home.nix ~/.config/nixpkgs/home.nix

# 3. Edit the username in home.nix
nano ~/.config/nixpkgs/home.nix
```

### Files Overview

| File | Purpose |
|------|---------|
| `modules/home-manager/` | Main home-manager module |
| `home-manager/home.nix` | Entry point - import modules here |
| `home-manager/symlinks.nix` | Symlink configs |

### Customization

Edit these files before running:

```bash
# Set your username in:
# - home-manager/home.nix (username variable)
# - home-manager/users.nix

# Add/remove packages in:
# - modules/home-manager/packages.nix

# Configure programs in:
# - modules/home-manager/programs.nix
```

### Apply

```bash
home-manager switch
```

### For Non-NixOS (Just Home-Manager)

Same as above - this works on any Linux with Nix installed.
