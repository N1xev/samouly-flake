set -g fish_greeting ''
set -Ux GI_TYPELIB_PATH $HOME/.nix-profile/lib/girepository-1.0
alias hr "home-manager switch --flake ~/Projects/flakey/#$USER"
alias nr "sudo nixos-rebuild switch --flake ~/Projects/flakey/#$HOST"
starship init fish | source
