{
  pkgs,
  ...
}:

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    # Bootloader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Kernel
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "console=ttyS0,115200n8" ];
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.gnome.gnome-keyring.enable = true;

  hardware = {
    # unstable way
    graphics = {
      enable = true;
      enable32Bit = true; # wine/steam/proton
    };

    # old 24.05 way
    # opengl = {
    #   enable = true;
    #   driSupport = true;
    #   driSupport32Bit = true;
    #
    #   # hacks for performance maybe?
    #   # package = pkgs-unstable.mesa.drivers; # wee
    #   # package32 = pkgs-unstable.pkgsi686Linux.mesa.drivers;
    #
    #   # extraPackages = [ pkgs-unstable.amdvlk ];
    #   # extraPackages32 = [ pkgs-unstable.amdvlk ];
    # };
  };

  # Force radv
  environment.variables = {
    # AMD_VULKAN_ICD = "RADV";
  };

  services = {
    displayManager = {
      defaultSession = "sway";
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "elarun";
      };
    };

    xserver = {
      # enable = true;
      xkb = {
        # Configure keymap in X11
        layout = "us";
        variant = "";
      };

      videoDrivers = [ "amdgpu" ];
    };
  };

  # Enable the GNOME Desktop Environment.
  # desktopManager.gnome.enable = true;
  # displayManager.sddm.enable = true;
  # windowManager.leftwm.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.pulseaudio = {
    enable = false;
    extraConfig = "load-module module-combine-sink";
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kevin = {
    isNormalUser = true;
    description = "kevin";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      firefox
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    font-awesome
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Utils
    wget
    sops # secrets
    file

    wl-clipboard

    # Programming
    gcc13
    podman-tui
    podman-compose
    dive

    # Gaming
    protonup
    mangohud
    vesktop
    lutris

    wireguard-tools
  ];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  hardware = {
    xone.enable = true;
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      # extraOptions = [
      #   "--unsupported-gpu"
      # ];
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
      # package = pkgs-unstable.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-wlr;
    };

    zsh.enable = true;

    steam = {
      enable = true;
      # gamescope -w 1920 -h 1080 -W 5120 -H 1440 -f -- %command%
      gamescopeSession.enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };

    # Steam: gamemoderun %command%
    # helldivers: gamemoderun %command% --use-d3d11 -USEALLAVAILABLECORES
    gamemode.enable = true;
  };

  xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  # Open ports in the firewall.
  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  # spotify: sync with devices: tcp/57621, cast devices: udp/5353

  networking = {
    firewall = {
      allowedTCPPorts = [
        22000
        57621
      ];
      allowedUDPPorts = [
        22000
        21027
        5353
      ];
      # Or disable the firewall altogether.
      # enable = false;
    };

    hosts = {
      "192.168.1.200" = [ "truenas.local" ];
    };
  };

  # FileSystems

  fileSystems = {
    "/mnt/nas1" = {
      device = "truenas.local:/mnt/FirstPool/Media";
      fsType = "nfs";
      options = [
        "nofail"
      ];
    };

    "/mnt/games" = {
      device = "/dev/disk/by-uuid/654e5dd5-2696-4ff6-b24f-4da81e54e459";
      fsType = "ext4";
      options = [
        "nofail"
      ];
    };

    #    "/mnt/arch" = {
    #      device = "/dev/disk/by-uuid/e169ae8b-01c1-488d-b6eb-6fe4c61f433a";
    #      fsType = "ext4";
    #    };

    #    "/mnt/windows" = {
    #      device = "/dev/disk/by-uuid/4E32E1A132E18DF1";
    #      fsType = "ntfs-3g";
    #    };

    "/mnt/new_home" = {
      device = "/dev/disk/by-uuid/03f6673a-f7be-4c3b-a216-b784929d9ad4";
      fsType = "ext4";
      options = [
        "nofail"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      randomizedDelaySec = "14m";
      options = "--delete-older-than 30d";
    };
  };
}
