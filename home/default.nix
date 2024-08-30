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
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.nix-index-database.hmModules.nix-index
  ];

  catppuccin.enable = true;

  gtk = {
    enable = true;
    catppuccin.icon.enable = true;
  };

  qt.style.catppuccin.enable = true;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    preferXdgDirectories = true;
    stateVersion = "24.11";

    packages = with pkgs; [
      act
      cmake
      devcontainer
      devenv
      gcc
      gnumake
      libtool
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      networkmanager_dmenu
      nixd
      nixfmt-rfc-style
      pavucontrol
      ranger
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    shellAliases = {
      cat = "bat";
      ls = "eza --git --ignore-glob .git";
      v = "nvim";
      be = "bundle exec";
      flat = "bundle exec flatware";
      flatr = "bundle exec flatware rspec";
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

  xdg = {
    enable = true;

    configFile = {
      "networkmanager-dmenu/config.ini".text = ''
        [dmenu]
        dmenu_command = fuzzel --dpi-aware=yes --dmenu
      '';
    };
  };

  programs = {
    alacritty = {
      enable = true;
      catppuccin.enable = false;

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

    bat = {
      enable = true;
      catppuccin.enable = false;
    };

    bottom = {
      enable = true;
      catppuccin.enable = true;
    };

    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      commandLineArgs = [ "--ozone-platform-hint=auto" ];
    };

    direnv.enable = true;

    eza = {
      enable = true;
      icons = true;
      git = true;
      extraOptions = [
        "--ignore-glob"
        ".git"
      ];
    };

    firefox.enable = true;

    fish = {
      enable = true;
      catppuccin.enable = true;
      interactiveShellInit = "set fish_greeting";
      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fishPlugins.plugin-git.src;
        }
      ];
    };

    gh.enable = true;

    git = {
      enable = true;
      userName = "hss-mateus";
      userEmail = "hss-mateus@pm.me";

      difftastic = {
        enable = true;
        display = "side-by-side-show-both";
      };

      extraConfig = {
        pull.ff = true;
        merge.conflictstyle = "diff3";
      };
    };

    newsboat = {
      enable = true;
      catppuccin.enable = false;
      urls = builtins.map (url: { inherit url; }) [
        "https://lobste.rs/rss"
        "https://cprss.s3.amazonaws.com/rubyweekly.com.xml"
        "https://ferd.ca/feed.rss"
        "http://www.rubyflow.com/rss"
        "https://www.bigbinary.com/blog/feed.xml"
        "https://rubyonrails.org/feed.xml"
        "https://lwn.net/headlines/newrss"
        "https://blog.arkency.com/feed.xml"
        "https://esoteric.codes/rss"
        "https://shopify.engineering/blog.atom"
        "https://hotwireweekly.com/rss"
      ];

      extraConfig = ''
        color listfocus        black blue bold
        color listfocus_unread black blue bold
        color info             black blue bold
      '';
    };

    nix-index.enable = true;
    nix-index-database.comma.enable = true;

    fuzzel = {
      enable = true;
      catppuccin.enable = true;
    };

    starship = {
      enable = true;
      catppuccin.enable = true;
    };
  };

  services.udiskie.enable = true;
}
