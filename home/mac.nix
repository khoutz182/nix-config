{ allowed-unfree-packages, config, lib, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kevin";
  home.homeDirectory = "/Users/kevin";
}
