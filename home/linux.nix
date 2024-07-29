{ allowed-unfree-packages, config, lib, pkgs, ... }:

{

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) allowed-unfree-packages;

    steam = pkgs.steam.override {
      extraPkgs = pkgs: with pkgs; [
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


  home.packages = (with pkgs; [
    polybarFull
    rofi
    picom
    feh
    dunst
    signal-desktop
    pavucontrol
    tofi
    waybar
    grimblast
    satty # screenshot annotation
    mindustry-wayland

    # Environment
    hyprlock
    hyprpaper
    hypridle
  ]);

  home.file = {
    "pirating" = {
      source = ./pirating;
      recursive = true;
    };
  };

}
