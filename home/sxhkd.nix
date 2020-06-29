{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "super + Return"                  = "st";
      "super + r"                       = "st -e ranger";
      "super + e"                       = "emacsclient -c";
      "super + d"                       = "dmenu_run -nb '#2e3440' -nf '#e5e9f0' -sb '#a3be8c' -sf '#2e3440' -fn 'Hasklig-10'";
      "super + b"                       = "firefox";
      "super + shift + {q,r}"           = "bspc {quit,wm -r}";
      "super + c"                       = "bspc node -c";
      "super + {t,@space,f}"            = "bspc node -t {tiled,floating,fullscreen}";
      "super + {_,shift + }{h,j,k,l}"   = "bspc node -{f,s} {west,south,north,east}";
      "super + {_,shift + }{1-9,0}"     = "bspc {desktop -f,node -d} '^{1-9,10}'";
      "super + alt + {h,j,k,l}"         = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
      "super + alt + shift + {h,j,k,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      "super + {Left,Down,Up,Right}"    = "bspc node -v {-20 0,0 20,0 -20,20 0}";
      "super + p"                       = "scrot -e 'mv $f ~/Images/screenshots/'";
    };
  };
}