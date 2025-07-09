{
  pkgs,
  lib,
  config,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kevin";
  home.homeDirectory = "/home/kevin";

  imports = [
    ./wm/sway.nix
    # ./wm/hyprland.nix
    ./wm/waybar.nix
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
      rofi
      signal-desktop-bin
      vlc
      mako
      pavucontrol
      grimblast
      satty # screenshot annotation
      mindustry-wayland
      protonvpn-cli_2
      gparted
      unzip
      jetbrains.idea-ultimate

      # Media
      spotify
      vlc
      zathura
      mediainfo
      # ffmpeg-full
      ffmpeg_7-full

      tutanota-desktop
    ]
  );

  home.file = {
    "pirating" = {
      source = ./pirating;
      recursive = true;
    };
  };

  home.pointerCursor =
    let
      cursor_package = pkgs.catppuccin-cursors.mochaSapphire;
      cursor_name = "catppuccin-mocha-sapphire-cursors";
      cursor_size = 32;
    in
    {
      gtk.enable = true;
      x11.enable = true;
      hyprcursor = {
        enable = true;
        size = cursor_size;
      };
      package = cursor_package;
      name = cursor_name;
      size = cursor_size;
    };

  programs = {
    firefox = {
      enable = true;
    };
    tofi = {
      enable = true;
      settings = {
        background-color = "#1B1D1EDF";
        text-color = "#FFFFFF";
        font = "sans";

        border-width = 5;
        border-color = "#092672AA";
        corner-radius = 20;

        width = 1280;
        height = 720;

        outline-width = 4;
        outline-color = "#080860AA";

        padding-top = 8;
        padding-bottom = 8;
        padding-left = 8;
        padding-right = 8;

        result-spacing = 25;
        num-results = 0;

        ascii-input = true;
      };
    };
  };
}
