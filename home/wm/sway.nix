{
  pkgs,
  ...
}:

{
  wayland = {
    windowManager = {
      sway = {
        enable = true;
        checkConfig = false;
        config = {
          modifier = "Mod4";
          terminal = "wezterm";
          menu = "tofi-drun | xargs swaymsg exec --";
          output = {
            DP-2 = {
              mode = "5120x1440@199.992Hz";
              bg = "~/.config/wallpapers/wide-solar-system.jpeg fill";
            };
          };
          bars = [
            {
              command = "${pkgs.waybar}/bin/waybar";
            }
          ];
          focus = {
            followMouse = true;
            mouseWarping = true;
          };
          gaps = {
            inner = 4;
          };
          window = {
            border = 2;
            titlebar = false;
          };
        };
        extraConfig = ''
          set $menu tofi-run | xargs swaymsg exec --
          bindsym Mod4+Shift+d exec $menu
        '';
      };
    };
  };
  services = {
    swayidle = {
      enable = true;
      extraArgs = [
        "-w"
      ];
      # systemdTarget = "sway-session.target";
      timeouts = [
        {
          timeout = 600;
          command = ''swaymsg "output * power off"'';
          resumeCommand = ''swaymsg "output * power on"'';
        }
      ];
    };
  };
}
