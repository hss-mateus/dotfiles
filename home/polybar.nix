{
  services.polybar = {
    enable = true;
    script = ''
      MONITOR=HDMI-0 polybar --reload default &
      MONITOR=DVI-1 polybar --reload default &
    '';
    config = {
      "module/bspwm" = {
        type                      = "internal/bspwm";
        enable-click              = false;
        enable-scroll             = false;
        label-focused-foreground  = "#abb2bf";
        label-occupied-foreground = "#545862";
        label-empty-foreground    = "#282c34";
      };

      "module/title" = {
        type              = "internal/xwindow";
        format-foreground = "#abb2bf";
        label-maxlen      = 80;
        label-empty       = "Desktop";
      };

      "module/date" = {
        type     = "internal/date";
        interval = 1;
        date     = "%H:%M";
        date-alt = "%Y-%m-%d%";
      };

      "bar/default" = {
        monitor = "\${env:MONITOR:}";
        wm-restack     = "bspwm";
        padding        = 1;
        background     = "#282c34";
        foreground     = "#abb2bf";
        font-0         = "Fira Code:pixelsize=10";
        modules-left   = "bspwm";
        modules-center = "title";
        modules-right  = "date";
      };
    };
  };
}
