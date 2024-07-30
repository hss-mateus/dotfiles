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
      DOOMDIR = "${configHome}/doomconfig";
      DOOMLOCALDIR = "${configHome}/doomlocal";
      DOOMPROFILELOADFILE = "${configHome}/doomlocal/load.el";
      LSP_USE_PLISTS = "true";
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
            inherit (config.home.sessionVariables)
              DOOMDIR
              DOOMLOCALDIR
              DOOMPROFILELOADFILE
              LSP_USE_PLISTS
              ;
          };
        }
      }/bin/doom-sync";
    in
    {
      emacs = {
        source = builtins.fetchGit {
          url = "https://github.com/doomemacs/doomemacs.git";
          rev = "0f30e1eca5f7cb9220d2d1caf4fef7214a86c339";
        };
        onChange = doomSyncScript;
      };

      "${config.home.sessionVariables.DOOMDIR}/init.el" = {
        source = ./init.el;
        onChange = doomSyncScript;
      };

      "${config.home.sessionVariables.DOOMDIR}/packages.el" = {
        source = ./packages.el;
        onChange = doomSyncScript;
      };

      "${config.home.sessionVariables.DOOMDIR}/config.el".source = ./config.el;
    };
}
