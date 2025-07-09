{
  pkgs,
  lib,
  ...
}:

{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "emacs";

      # dotDir = ".config/zsh";
      # initContent = "for config in ~/.config/zsh/*.zsh; source $config";
      # initContent = lib.mkOrder 1200 (builtins.readFile ./terminal_fix.zsh);
      initContent =
        let
          terminalFix = lib.mkOrder 1200 (builtins.readFile ./terminal_fix.zsh);
          videoConversion = lib.mkOrder 1200 (builtins.readFile ./video_conversion.zsh);
        in
        lib.mkMerge [
          terminalFix
          videoConversion
        ];
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        scan_timeout = 10;
        gradle = {
          symbol = " ";
        };
      };
    };
  };

  home.shellAliases = {
    l = "eza -lh";
    ls = "eza";
    ll = "eza -l";
    la = "eza -ah";
    lla = "eza -lah";
    man = "batman";
    vim = "nvim";
    sxiv = "sxiv -r -t -p";
    nix-shell = "nix-shell --command zsh";

    "..." = "../..";
    "...." = "../../..";
    "....." = "../../../..";

    vimdiff = "nvim -d";

    # git stuffs

    g = "git";

    ga = "git add";
    gaa = "git add --all";
    gapa = "git add --patch";
    gau = "git add --update";
    gav = "git add --verbose";

    gb = "git branch";
    gbl = "git blame -b -w";
    gbnm = "git branch --no-merged";
    gbr = "git branch --remote";
    gst = "git status";

    gc = "git commit -v";
    gca = "git commit -v -a";

    gwt = "git worktree";

    gclean = "git clean -id";
    gr = "git restore";
    grs = "git restore --staged";
    gpristine = "git reset --hard && git clean -dffx";
    gcm = "git checkout $(git_main_branch)";
    gcb = "git checkout -b";
    gco = "git checkout";
    gcp = "git cherry-pick";
    gcpa = "git cherry-pick --abort";
    gcpc = "git cherry-pick --continue";

    gd = "git diff";
    gdca = "git diff --cached";
    gdcw = "git diff --cached --word-diff";
    gds = "git diff --staged";
    gdt = "git diff-tree --no-commit-id --name-only -r";
    gdup = "git diff @{upstream}";
    gdw = "git diff --word-diff";
    gdss = "git diff --shortstat";

    gri = "git rebase -i";
    grim = "git rebase -i $(git_main_branch)";

    groh = "git reset origin/$(git_current_branch) --hard";

    ggpull = "git pull origin \"$(git_current_branch)\"";
    ggpush = "git push origin \"$(git_current_branch)\"";

    ggsup = "git branch --set-upstream-to=origin/$(git_current_branch)";
    gpsup = "git push --set-upstream origin $(git_current_branch)";
    gpull = "git pull --prune";
    glg = "git log --stat";
    glgp = "git log --stat -p";
    glgg = "git log --graph";
    glgga = "git log --graph --decorate --all";
    glgm = "git log --graph --max-count=10";
    glo = "git log --oneline --decorate";
    glol = "git log --graph --pretty='%Cred%h%Creset - %C (auto)%d%Creset %s %Cgreen (%ar) %C (bold blue) < %an>%Creset'    ";
    glols = "git log --graph --pretty='%Cred%h%Creset - %C (auto)%d%Creset %s %Cgreen (%ar) %C (bold blue) < %an>%Creset    ' --stat";
    glod = "git log --graph --pretty='%Cred%h%Creset - %C (auto)%d%Creset %s %Cgreen (%ad) %C (bold blue) < %an>%Creset'    ";
    glods = "git log --graph --pretty='%Cred%h%Creset - %C (auto)%d%Creset %s %Cgreen (%ad) %C (bold blue) < %an>%Creset    ' --date=short";
    glola = "git log --graph --pretty='%Cred%h%Creset - %C (auto)%d%Creset %s %Cgreen (%ar) %C (bold blue) < %an>%Creset    ' --all";
    glog = "git log --oneline --decorate --graph";
    gloga = "git log --oneline --decorate --graph --all";

    # disable correction
    cd = "nocorrect cd";
    cp = "nocorrect cp";
    mv = "nocorrect mv";
    grep = "nocorrect grep";
    rg = "nocorrect rg";
    z = "nocorrect z";
  };
}
