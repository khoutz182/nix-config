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
          sha256 = "w0DUIh1HRiZKHzQT2PrZadS0nBebOnL+Qi3y4g9OpmE=";
        };
      }
    ];

	dotDir = ".config/zsh";

    initExtra = "for config in ~/.config/zsh/*.zsh; source $config";
	completionInit = "";
  };

  programs.zoxide.enable = true;
}
