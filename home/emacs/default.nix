{
  config,
  pkgs,
  inputs,
  ...
}:

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
      extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
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

      inherit (config.home.sessionVariables) DOOMDIR;
    in
    {
      emacs = {
        source = inputs.doom-emacs;
        onChange = doomSyncScript;
      };

      "${DOOMDIR}/init.el" = {
        source = ./init.el;
        onChange = doomSyncScript;
      };

      "${DOOMDIR}/packages.el" = {
        source = ./packages.el;
        onChange = doomSyncScript;
      };

      "${DOOMDIR}/config.el".source = ./config.el;
    };
}
