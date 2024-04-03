{ config, lib, pkgs, pkgs-unstable, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode;
    extensions = with pkgs-unstable.vscode-extensions; [
      mkhl.direnv # direnv support
      vscodevim.vim # vim keybinding

      # language
      rust-lang.rust-analyzer # for rust developement
      bbenoist.nix # Nix language support
    ];
    userSettings = {
      "workbench.colorTheme" = "Monokai";
      "workbench.startupEditor" = "none";

      "editor.fontSize" = 17;
      "editor.formatOnSave" = true;
      "editor.fontFamily" = "Monaco, 'Droid Sans Mono', 'monospace', monospace";

      "explorer.confirmDelete" = false;

      "update.showReleaseNotes" = false;

      # Vim settings
      "vim.leader" = "<space>";
      "vim.useSystemClipboard" = true;
      "vim.insertModeKeyBindings" = [
        {
          before = [ "j" "k" ];
          after = [ "<Esc>" ];
        }
        {
          before = [ "k" "j" ];
          after = [ "<Esc>" ];
        }
      ];
      "vim.normalModeKeyBindings" = [{
        before = [ "<leader>" "f" "s" ];
        commands = [ "workbench.action.files.save" ];
      }];
    };
  };
  home.packages = with pkgs; [ nixfmt ];
}
