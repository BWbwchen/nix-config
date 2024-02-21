{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      autocd = true;
      enableCompletion = true;

      oh-my-zsh = { # Extra plugins for zsh
        enable = true;
        theme = "af-magic";
        plugins = [ "git" "fzf" ];
      };

      shellAliases = {
        vim = "lvim";
        df = "duf";
        nix-history =
          "nix profile history --profile /nix/var/nix/profiles/system";
        nix-clean-xdays =
          "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than ";
        nix-gc = "sudo nix store gc --debug";
      };
    };

    fzf = { enable = true; };
  };
}
