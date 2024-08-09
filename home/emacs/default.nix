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
          rev = "cf7098528d2a21c29d497cd810faa0a77ecaf4cc";
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
