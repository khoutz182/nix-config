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
#     initExtra = ''
# source $HOME/.config/zsh/00-environment.zsh
# source $HOME/.config/zsh/01-prompt.zsh
# source ~/.config/zsh/30-options.zsh
# source ~/.config/zsh/40-aliases.zsh
# source ~/.config/zsh/50-history.zsh
# source ~/.config/zsh/fzf.zsh
# source ~/.config/zsh/movie-conversion.zsh
# source ~/.config/zsh/ssh.zsh
# 	'';
  };

  programs.zoxide.enable = true;
}
