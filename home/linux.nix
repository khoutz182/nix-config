{
  allowed-unfree-packages,
  config,
  lib,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kevin";
  home.homeDirectory = "/home/kevin";

  imports = [
    ./wm/sway.nix
    ./wm/hyprland.nix
  ];

  xdg = {
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };
    desktopEntries = {
      firefox = {
        name = "Firefox";
        genericName = "Web Browser";
        exec = "${pkgs.firefox}/bin/firefox %U";
        terminal = false;
        categories = [
          "Application"
          "Network"
          "WebBrowser"
        ];
        mimeType = [
          "text/html"
          "text/xml"
        ];
      };
    };
  };

  nixpkgs.config = {
    steam = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };
  };

  home.packages = (
    with pkgs;
    [
      polybarFull
      rofi
      picom
      feh
      signal-desktop
      vlc
      mako
      pavucontrol
      tofi
      waybar
      wttrbar # weather for waybar
      grimblast
      satty # screenshot annotation
      mindustry-wayland
      protonvpn-cli_2
      jetbrains-toolbox
      gparted
      unzip

      # Media
      spotify
      vlc
      zathura
      mediainfo
      # ffmpeg-full
      ffmpeg_7-full
      amf

      gpxsee

      # Environment
      # hyprlock
      # hyprpaper
      # hypridle
    ]
  );

  home.file = {
    "pirating" = {
      source = ./pirating;
      recursive = true;
    };
  };
}
