{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    # autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";

    plugins = [
      {
        name = "znap";
        file = "znap.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-snap";
          rev = "main";
          sha256 = "kzdazrlsPlbo4fyOMBL9Y7PE/Oo37fHU7Uy6wdaVtgE=";
        };
      }
    ];

    dotDir = ".config/zsh";

    initExtra = "for config in ~/.config/zsh/*.zsh; source $config";
    completionInit = "";
  };

  programs.zoxide.enable = true;
}
