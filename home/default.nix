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
    inputs.doom-emacs.hmModule
  ];

  catppuccin = {
    enable = true;
    swaylock.enable = true;
    gtk.icon.enable = true;
  };

  stylix.targets = {
    alacritty.enable = false;
    bat.enable = false;
    btop.enable = false;
    yazi.enable = false;
    swaylock.enable = false;
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
      devenv
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
      ls = "eza --git --ignore-glob .git";
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
      icons = "auto";
      git = true;
      extraOptions = [
        "--ignore-glob"
        ".git"
      ];
    };

    firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };

    fish = {
      enable = true;
      interactiveShellInit = "set fish_greeting";
      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fishPlugins.plugin-git.src;
        }
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
        "https://shopify.engineering/blog.atom"
        "https://hotwireweekly.com/rss"
        "https://byroot.github.io/feed.xml"
      ];
    };

    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    starship.enable = true;
    yazi.enable = true;
  };

  services = {
    udiskie.enable = true;
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
  };
}
