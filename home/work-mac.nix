{ allowed-unfree-packages, config, lib, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kevinhoutz";
  home.homeDirectory = "/Users/kevinhoutz";


  home.packages = (with pkgs; [
    maven
    awscli2
  ]);

  home = {
    file = {
      ".config/zsh/mwt.zsh".source = mwt/zsh/mwt.zsh;
    };
  };

}

