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

      shellAliases = { vim = "lvim"; };
    };

    fzf = { enable = true; };
  };
}
