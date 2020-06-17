{
  services.polybar = {
    enable = true;
    script = "polybar default &";
    config = {
      "module/bspwm" = {
        type                      = "internal/bspwm";
        enable-click              = false;
        enable-scroll             = false;
        label-focused-foreground  = "#d8dee9";
        label-occupied-foreground = "#4c566a";
        label-empty-foreground    = "#2e3440";
      };

      "module/title" = {
        type              = "internal/xwindow";
        format-foreground = "#d8dee9";
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
        wm-restack     = "bspwm";
        padding        = 1;
        background     = "#2e3440";
        foreground     = "#d8dee9";
        font-0         = "Hasklig:pixelsize=11";
        modules-left   = "bspwm";
        modules-center = "title";
        modules-right  = "date";
      };
    };
  };
}
