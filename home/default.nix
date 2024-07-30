{ config, pkgs, ... }:

{
  imports = [
    ./emacs
    ./wm
  ];

  home = {
    username = "mt";
    homeDirectory = "/home/mt";
    preferXdgDirectories = true;
    stateVersion = "24.11";

    keyboard = {
      layout = "us,us(intl)";
      model = "qwerty";
      options = [
        "grp:alt_space_toggle"
        "caps:escape"
      ];
    };

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
        dmenu_command = rofi -dmenu
      '';
    };
  };

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
    bottom.enable = true;

    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
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
      interactiveShellInit = "set fish_greeting";
      plugins = [
        {
          name = "plugin-git";
          src = builtins.fetchGit {
            url = "https://github.com/jhillyerd/plugin-git.git";
            rev = "6336017c16c02b1e9e708dd4eb233e66a18b62fe";
          };
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
      ];

      extraConfig = ''
        color listfocus        black blue bold
        color listfocus_unread black blue bold
        color info             black blue bold
      '';
    };

    starship.enable = true;
  };
}
