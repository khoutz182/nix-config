{
  pkgs,
  ...
}:
{
  home.packages = (
    with pkgs;
    [
      waybar
      wttrbar
    ]
  );

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    style = builtins.readFile ./waybar-style.css;
    settings = {
      mainBar = {
        height = 30;
        spacing = 4;
        reload_style_on_change = true;
        output = [ "DP-2" ];

        modules-left = [
          "sway/workspaces"
          "hyprland/workspaces"
          "sway/mode"
        ];
        modules-center = [
          "sway/window"
          "hyprland/window"
        ];
        modules-right = [
          "idle_inhibitor"
          "custom/weather"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "clock"
          "tray"
        ];

        # Window manager configs
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "sway/window" = {
          icon = true;
        };
        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };
        "hyprland/workspaces" = {
          active-only = false;
        };
        "hyprland/window" = {
          icon = true;
        };

        # Other configs
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          format = "{:%Y-%m-%d %I:%M %p} ";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
          interval = 3;
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        network = {
          format-linked = "{ifname} (No IP)";
          format-ethernet = "{ipaddr}";
          format-wifi = "{essid} ({signalStrength}%) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
          format = "{volume}% {icon}    {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "hf";
            headset = "h";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
          scroll-step = 5.0;
        };
        "custom/weather" = {
          format = "{}°";
          tooltip = true;
          interval = 3600;
          return-type = "json";
          exec = "${pkgs.wttrbar}/bin/wttrbar --location Chicago --fahrenheit --mph";
        };
      };
    };
  };
}
