{ config, pkgs, ... }:

with config.xdg;
{
  home = {
    packages = with pkgs; [
      editorconfig-core-c
      emacs-lsp-booster
      ripgrep
    ];

    sessionPath = [ "${configHome}/emacs/bin" ];

    sessionVariables = {
      DOOMDIR = "${configHome}/doom/config";
      DOOMLOCALDIR = "${configHome}/doom/local";
      DOOMPROFILELOADFILE = "${configHome}/doom/local/load.el";
    };
  };

  programs = {
    emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
    };

    fd.enable = true;
  };

  xdg.configFile =
    let
      doomSyncScript = "${
        pkgs.writeShellApplication {
          name = "doom-sync";
          text = ''
            if [ ! -d "$DOOMLOCALDIR" ]; then
              ${configHome}/emacs/bin/doom install --force
            else
              ${configHome}/emacs/bin/doom --force sync -u
            fi
          '';
          runtimeInputs = config.home.packages ++ config.home.sessionPath;
          runtimeEnv = {
            inherit (config.home.sessionVariables) DOOMDIR DOOMLOCALDIR DOOMPROFILELOADFILE;
          };
        }
      }/bin/doom-sync";
    in
    {
      emacs = {
        source = builtins.fetchGit {
          url = "https://github.com/doomemacs/doomemacs.git";
          rev = "f5b3958331cebf66383bf22bdc8b61cd44eca645";
        };
        onChange = doomSyncScript;
      };

      "doom/config/init.el" = {
        source = ./init.el;
        onChange = doomSyncScript;
      };

      "doom/config/packages.el" = {
        source = ./packages.el;
        onChange = doomSyncScript;
      };

      "doom/config/config.el".source = ./config.el;
    };
}
