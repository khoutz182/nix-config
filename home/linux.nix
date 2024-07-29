{ allowed-unfree-packages, config, lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kevin";
  home.homeDirectory = "/home/kevin";

  nixpkgs.config = {
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
    vlc
    pavucontrol
    tofi
    waybar
    grimblast
    satty # screenshot annotation
    mindustry-wayland
    protonvpn-cli_2
    jetbrains-toolbox

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
