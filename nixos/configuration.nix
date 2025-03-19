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
    ./hardware-configuration2.nix
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

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n =
    let
      locale = "en_US.UTF-8";
    in
    {
      defaultLocale = locale;
      extraLocaleSettings = {
        LC_ADDRESS = locale;
        LC_IDENTIFICATION = locale;
        LC_MEASUREMENT = locale;
        LC_MONETARY = locale;
        LC_NAME = locale;
        LC_NUMERIC = locale;
        LC_PAPER = locale;
        LC_TELEPHONE = locale;
        LC_TIME = locale;
      };
    };

  hardware = {
    xone.enable = true;
    # unstable way
    graphics = {
      enable = true;
      enable32Bit = true; # wine/steam/proton
    };
  };

  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.kevin = {
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

  # Force radv
  environment.variables = {
    # AMD_VULKAN_ICD = "RADV";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs = {
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

    sway = {
      enable = true;
    };
    hyprland = {
      enable = true;
    };
  };

  # List services that you want to enable:
  services = {
    # pulseaudio = {
    #   enable = false;
    # };
    gnome = {
      gnome-keyring.enable = true;
    };
    displayManager = {
      defaultSession = "sway";
      sddm = {
        enable = true;
        wayland.enable = true;
        theme = "maldives";
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

    # Enable CUPS to print documents.
    printing = {
      enable = true;
      drivers = with pkgs; [
        brlaser
        brgenml1lpr
      ];
    };

    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
      wireplumber = {
        enable = true;
      };

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };
  };

  # Open ports in the firewall.
  # Syncthing ports: 8384 for remote access to GUI
  # 22000 TCP and/or UDP for sync traffic
  # 21027/UDP for discovery
  # source: https://docs.syncthing.net/users/firewall.html
  # spotify: sync with devices: tcp/57621, cast devices: udp/5353

  networking = {
    hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
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
      device = "/dev/disk/by-uuid/b5eef2ec-6061-4d00-b5cd-479e49e5d976";
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
