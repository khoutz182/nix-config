{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    hyprpaper
    hypridle
    # hyprlock
  ];

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        extraConfig = builtins.readFile ./hyprland.conf;
        settings = {
          decoration = {
            rounding = "3";
            blur = {
              enabled = true;
              size = 3;
              passes = 1;
            };
            # shadow_offset = "0 5";
            # "col.shadow" = "rgba(00000099)";
          };

          "$mod" = "SUPER";

          bindm = [
            # Move/resize windows with mainMod + LMB/RMB and dragging
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
            "$mod ALT, mouse:272, resizewindow"
          ];
        };
      };
    };
  };

  services = {
    hypridle = {
      enable = true;
      settings = {
        general = {
          # lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
          before_sleep_cmd = "loginctl lock-session";
        };

        listener = [
          {
            timeout = 600;
            on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
            on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
          }
        ];
      };
    };
    hyprpaper = {
      enable = true;
      settings =
        let
          wallpaper = "~/.config/wallpapers/wide-solar-system.jpeg";
        in
        {
          splash = false;
          preload = [ wallpaper ];
          wallpaper = [ "DP-2,${wallpaper}" ];
        };
    };
  };
}
