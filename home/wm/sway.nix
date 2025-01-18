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
        systemd.enable = true;
        config = {
          defaultWorkspace = "workspace number 1";
          modifier = "Mod4";
          terminal = "wezterm";
          menu = "tofi-drun | xargs swaymsg exec --";
          output = {
            DP-2 = {
              mode = "5120x1440@199.992Hz";
              bg = "~/.config/wallpapers/wide-solar-system.jpeg fill";
            };
          };
          bars = [ ]; # use the systemd service now
          #   {
          #     command = "${pkgs.waybar}/bin/waybar";
          #   }
          focus = {
            followMouse = "always";
            mouseWarping = "container";
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
          bindsym Print exec grimblast copy area
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
          command = ''${pkgs.sway}/bin/swaymsg "output * power off"'';
          resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * power on"'';
        }
      ];
    };
  };
}
