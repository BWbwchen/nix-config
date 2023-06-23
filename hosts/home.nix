{ config, pkgs, user, ... }:

{
  imports = [ ./apps.nix ../modules/i3 ];

  programs.home-manager.enable = true;

  programs.direnv.enable = true;

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "22.11";
    sessionPath =
      [ "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.emacs.d/bin" ];
  };

  programs.bash = { enable = true; };

  programs.zsh = {
    enable = true;
    initExtra = ''
      export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.emacs.d/bin:$PATH
    '';
  };
}

