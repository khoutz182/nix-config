{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    hyprpaper
    hypridle
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
            shadow_offset = "0 5";
            "col.shadow" = "rgba(00000099)";
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
}
