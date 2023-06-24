{ pkgs, lib, config, configDir, fetchFromGitHub, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };
  # services.emacs.enable = true;
  home.activation.doom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    EMACS="$HOME/.emacs.d"
    DOOM="$HOME/.doom.d"
    if [ ! -d "$EMACS" ]; then
      ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs $EMACS
      ln -sf $HOME/nix-config/modules/emacs/doom.d $DOOM
    fi
  '';
  home.packages = with pkgs; [
    # Doom Emacs fonts, manually installed with
    # M-x all-the-icons-install-fonts
    emacs-all-the-icons-fonts
    # Spellcheck
    ispell
  ];
}

