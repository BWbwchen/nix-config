{ pkgs, lib, config, configDir, fetchFromGitHub, ... }:

{
  programs.emacs = {
    enable = true;
    # package = pkgs.emacs-gtk;
  };
  # services.emacs.enable = true;
  # home.activation.doom = lib.hm.dag.entryAfter["writeBoundary"] ''
  #   if [ ! -d .emacs.d ]; then
  #     git clone --depth 1 https://github.com/doomemacs/doomemacs .emacs.d
  #   fi
  #   mkdir -p .doom.d
  #   ln -sf ${config.home.homeDirectory}/${configDir}/modules/emacs/doom.d/* .doom.d
  # '';
  # home.file = {
  #   ".emacs.d/everforest".source = pkgs.fetchFromGitHub {
  #     owner = "Theory-of-Everything";
  #     repo = "everforest-emacs";
  #     rev = "703b16b742b753f6ad077b5c7f51947d1926c530";
  #     sha256 = "sha256-ZtpN6wM+R+4w1FCO6axWRNFX8feSau/o3V/wnw5EiJQ=";
  #   };
  # };
  home.packages = with pkgs; [
    # Doom Emacs fonts, manually installed with
    # M-x all-the-icons-install-fonts
    emacs-all-the-icons-fonts
    # Spellcheck
    ispell
  ];
}

