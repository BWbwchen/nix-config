{ config, lib, pkgs, user, state_version, ... }:

{
  imports = [
    ../modules/git # git
    ../modules/zsh.nix
    ../modules/tmux
  ];

  programs.home-manager.enable = true;

  programs.direnv.enable = true;

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = state_version;
    sessionPath =
      [ "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.emacs.d/bin" ];
  };

  programs.bash = { enable = true; };

  programs.zsh = {
    enable = true;
    initExtra = ''
      export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.emacs.d/bin:$PATH;
      export LD_LIBRARY_PATH="";
    '';
  };

  home.packages = with pkgs; [
    # Command line utilities
    neovim
    wget
    curl

    htop
    neofetch

    # misc
    gnupg
    duf

    # Programming languages

    # Other
  ];
}
