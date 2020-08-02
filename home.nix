{ pkgs, ... }:

{
  home.stateVersion = "20.03";

  programs = {
    git = {
      enable = true;
      userName = "hss-mateus";
      userEmail = "hss-mateus@tuta.io";
      extraConfig.credential.helper = "store";
    };

    neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ vim-sensible base16-vim auto-pairs ];
      withNodeJs = true;
      extraConfig = ''
        set hidden
        set termguicolors
        set clipboard+=unnamedplus
        set number
        set tabstop=2
        set softtabstop=2
        set shiftwidth=2
        set expandtab
        set colorcolumn=81

        colorscheme base16-onedark
      '';
    };

    zathura = {
      enable = true;
      options = {
        default-bg = "#282c34";
        default-fg = "#353b45";
        statusbar-fg = "#565c64";
        statusbar-bg = "#3e4451";
        recolor-lightcolor = "#282c34";
        recolor-darkcolor = "#b6bdca";
        recolor = true;
        recolor-keephue = false;
      };
    };

    newsboat = {
      enable = true;
      extraConfig = ''
        color listfocus        black blue bold
        color listfocus_unread black blue bold
        color info             black blue bold
      '';
      urls = [
        { url = "https://news.ycombinator.com/rss"; }
        { url = "https://lobste.rs/rss"; }
        { url = "https://afreshcup.com/feed.xml"; }
        { url = "https://mshibanami.github.io/GitHubTrendingRSS/daily/all.xml"; }
        { url = "https://mshibanami.github.io/GitHubTrendingRSS/daily/unknown.xml"; }
        { url = "https://elmbits.com/rss/"; }
        { url = "https://cprss.s3.amazonaws.com/weekly.statuscode.com.xml"; }
        { url = "https://xkcd.com/atom.xml"; }
        { url = "https://cprss.s3.amazonaws.com/rubyweekly.com.xml"; }
        { url = "https://whatthefuck.is/feed.xml"; }
        { url = "https://ferd.ca/feed.rss"; }
      ];
    };
  };

  xsession.enable = true;

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
  };

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad.hs;
  };

  home.file.".xmobarrc".source = ./xmobar;
}
