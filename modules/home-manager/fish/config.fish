set -g fish_greeting ''
alias hr "home-manager switch --flake .#$hostname --impure"
alias nr "sudo nixos-rebuild switch --flake .#main --impure"
starship init fish | source