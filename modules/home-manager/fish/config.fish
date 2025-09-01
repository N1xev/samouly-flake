set -g fish_greeting ''
alias hr "home-manager switch --flake .#$USER --impure"
alias nr "sudo nixos-rebuild switch --flake .#nixos --impure"
starship init fish | source