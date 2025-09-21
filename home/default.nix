{
  pkgs,
  inputs,
  user,
  ...
}:
{
  imports = [
    ./emacs
    ./wm
    inputs.catppuccin.homeModules.catppuccin
    inputs.nix-index-database.hmModules.nix-index
    inputs.doom-emacs.hmModule
  ];

  catppuccin = {
    enable = true;
    swaylock.enable = true;
    gtk.icon.enable = true;
    firefox.profiles.default.enable = false;
  };

  stylix.targets = {
    alacritty.enable = false;
    bat.enable = false;
    btop.enable = false;
    yazi.enable = false;
    starship.enable = false;
    swaylock.enable = false;
    swaync.enable = false;
    qt.enable = false;
  };

  gtk.enable = true;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    preferXdgDirectories = true;
    stateVersion = "24.11";

    packages = with pkgs; [
      act
      devcontainer
      nerd-fonts.symbols-only
      nixd
      nixfmt-rfc-style
      pavucontrol
      ueberzugpp
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    shellAliases = {
      cat = "bat";
      v = "nvim";
    };

    file.".irbrc".text = ''
      IRB.conf.merge!(
        PROMPT_MODE: :SIMPLE,
        USE_MULTILINE: false,
        USE_SINGLELINE: true,
        USE_READLINE: true
      )
    '';
  };

  xdg.enable = true;

  programs = {
    alacritty = {
      enable = true;
      settings = {
        mouse.hide_when_typing = true;
        window.dynamic_padding = true;

        keyboard.bindings = [
          {
            action = "IncreaseFontSize";
            key = "Equals";
            mods = "Control";
          }
          {
            action = "DecreaseFontSize";
            key = "Minus";
            mods = "Control";
          }
          {
            action = "ResetFontSize";
            key = "Key0";
            mods = "Control";
          }
          {
            action = "ScrollPageUp";
            key = "K";
            mods = "Control|Shift";
          }
          {
            action = "ScrollPageDown";
            key = "J";
            mods = "Control|Shift";
          }
        ];
      };
    };

    bat.enable = true;

    btop.enable = true;

    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      commandLineArgs = [ "--ozone-platform-hint=auto" ];
    };

    direnv.enable = true;

    eza = {
      enable = true;
      colors = "auto";
      icons = "auto";
      git = true;
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };

    fish = {
      enable = true;
      plugins = [
        { inherit (pkgs.fishPlugins.plugin-git) name src; }
      ];
    };

    fuzzel.enable = true;
    gh.enable = true;

    git = {
      enable = true;
      userName = "hss-mateus";
      userEmail = "hss-mateus@pm.me";

      delta.enable = true;

      extraConfig = {
        pull.ff = true;
        merge.conflictstyle = "diff3";
      };
    };

    neovim = {
      enable = true;
      extraConfig = "set clipboard+=unnamedplus";
    };

    newsboat = {
      enable = true;
      urls = builtins.map (url: { inherit url; }) [
        "https://lobste.rs/rss"
        "https://cprss.s3.amazonaws.com/rubyweekly.com.xml"
        "https://ferd.ca/feed.rss"
        "http://www.rubyflow.com/rss"
        "https://rubyonrails.org/feed.xml"
        "https://lwn.net/headlines/newrss"
        "https://blog.arkency.com/feed.xml"
        "https://esoteric.codes/rss"
        "https://railsatscale.com/feed.xml"
        "https://byroot.github.io/feed.xml"
        "http://feeds.feedburner.com/patshaughnessy"
        "https://retropolis.com.br/feed/podcast"
        "https://us20.campaign-archive.com/feed?u=fd00d355531c767dc0176f9cc&id=53bc3d187d"
      ];
    };

    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    yazi.enable = true;
  };

  services = {
    udiskie.enable = true;
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };
}
