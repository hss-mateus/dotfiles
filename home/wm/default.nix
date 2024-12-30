{
  pkgs,
  config,
  osConfig,
  ...
}:

{
  imports = [
    ./sway.nix
    ./waybar.nix
  ];

  programs.swaylock.enable = true;

  services = {
    swaync.enable = true;

    swayidle =
      let
        swaymsg = "${osConfig.programs.sway.package}/bin/swaymsg";
        swaylock = "${config.programs.swaylock.package}/bin/swaylock";
        light = "${pkgs.light}/bin/light";
        loginctl = "${pkgs.systemd}/bin/loginctl";
        systemctl = "${pkgs.systemd}/bin/systemctl";
      in
      {
        enable = true;
        systemdTarget = "sway-session.target";

        events = [
          {
            event = "before-sleep";
            command = "${loginctl} lock-session";
          }
          {
            event = "lock";
            command = "${swaylock} -f";
          }
        ];

        timeouts = [
          {
            timeout = 150;
            command = "${light} -O && ${light} -S 10";
            resumeCommand = "${light} -I";
          }
          {
            timeout = 300;
            command = "${loginctl} lock-session";
          }
          {
            timeout = 330;
            command = "${swaymsg} 'output * power off'";
            resumeCommand = "${swaymsg} 'output * power on'";
          }
          {
            timeout = 1800;
            command = "${pkgs.writeShellScript "suspend" ''
              file=/sys/class/power_supply/AC/online

              if [ ! -f $file ] || [ "$(cat $file)" = "1" ]; then
                ${systemctl} suspend
              else
                ${systemctl} suspend-then-hibernate
              fi
            ''}";
          }
        ];
      };
  };
}
