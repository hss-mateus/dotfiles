{
  xsession.windowManager.bspwm = {
    enable = true;
    monitors.VGA-0 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ];
    startupPrograms = [
      "wmname LG3D"
      "xsetroot -cursor_name left_ptr"
    ];
    rules = {
      Emacs.state = "tiled";
      Zathura.state = "tiled";
    };
    settings = {
      focus_follows_pointer = true;
      border_width = 0;
      window_gap = 0;
    };
  };
}
