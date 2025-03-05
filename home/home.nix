{
  allowed-unfree-packages,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./programs/zsh.nix
    # ./programs/nvf.nix # new neovim
    ./programs/nvim.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (
    with pkgs;
    [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" ]; })
      # font-awesome

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')

      jq
      yq
      bat
      xh
      ripgrep
      eza
      keepassxc
      discord
      kitty
      wezterm
      dive

      # programming
      typstfmt
      gcc
      lldb
      kubectl
      scaleway-cli
      k9s
      zola
    ]
  );

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config" = {
      source = ./config;
      recursive = true;
    };
  };

  services.syncthing.enable = true;

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kevin/etc/profile.d/hm-session-vars.sh
  #
  # home.sessionVariables = { EDITOR = "nvim"; };

  home = {
    sessionPath = [
      "$HOME/.cargo/bin"
    ];

    sessionVariables = {
      # Needed for rust-analyzer and the like
      # Use in nix-shell
      # RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };

  programs = {
    librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.clearOnShutdown.history" = false;
        "network.cookie.lifetimePolicy" = 0;
      };
    };

    git = {
      enable = true;
      userEmail = "kevin@houtz.dev";
      userName = "Kevin Houtz";
      lfs = {
        enable = true;
      };

      delta = {
        enable = false;
      };
      difftastic = {
        enable = false;
      };
      diff-so-fancy = {
        enable = true;
      };

      extraConfig = {
        init.defaultBranch = "main";
        fetch = {
          prune = true;
          pruneTags = true;
          all = true;
        };

        merge = {
          conflictstyle = "diff3";
          tool = "nvim";
        };

        mergetool = {
          prompt = false;
          keepBackup = false;
        };

        branch.sort = "-comitterdate";
        tag.sort = "version:refname";

        "mergetool \"nvim\"".cmd = "nvim -c DiffviewOpen";
        pull.ff = "only";

        diff = {
          algorithm = "histogram";
          colorMoved = "plain";
          mneumonicPrefix = true;
          renames = true;
        };

        push = {
          default = "simple";
          autoSetupRemote = true;
          followTags = true;
        };
      };
    };

    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batman
        batwatch
      ];
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
