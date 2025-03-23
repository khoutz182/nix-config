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

  home.activation = {
    # https://github.com/philj56/tofi/issues/115#issuecomment-1950273960
    regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      		tofi_cache=${config.xdg.cacheHome}/tofi-drun
      		[[ -f "$tofi_cache" ]] && rm "$tofi_cache"
      		'';
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
      signal-desktop
      vlc
      mako
      pavucontrol
      tofi
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
}
