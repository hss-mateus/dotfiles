{
  config,
  pkgs,
  osConfig,
  ...
}:

{
  programs = {
    swaylock.enable = true;
    waybar.settings.mainBar = {
      temperature.thermal-zone = 2;

      modules-right = [ "idle_inhibitor" ];

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
    };
  };

  wayland.windowManager.sway.config = {
    input."*".xkb_layout = "us,us(intl),br";

    output = {
      HDMI-A-1.pos = "1536 0";
      eDP-1 = {
        pos = "0 0";
        scale = "1.25";
      };
    };
  };

  services.swayidle =
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
          command = "${systemctl} suspend-then-hibernate";
        }
      ];
    };
}
