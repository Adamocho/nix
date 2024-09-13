# Help is available in the configuration.nix(5) man page
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # For the SSD
  services.fstrim.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;
  #boot.kernelParams = ["quiet"]; # Is this optional?
  boot.initrd.luks.devices."luks-eab86c67-aed2-4de4-acf8-0d7011cca2d6".device = "/dev/disk/by-uuid/eab86c67-aed2-4de4-acf8-0d7011cca2d6";
  networking.hostName = "moon"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
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

  # Manpages
  documentation.enable = true;
  documentation.dev.enable = true;
  documentation.man.enable = true;
  documentation.man.generateCaches = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.adam = {
    isNormalUser = true;
    description = "Adam";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Applications
      vscodium
      obsidian
      #gimp
      #vlc
      #blender
      #audacity
      #filezilla
      #krita

      # Editors
      alacritty
      tmux

      # Others
      bemenu

      # Terminal tools && just tools.
      htop
      plocate
      cron
      binwalk
      strace
      ltrace
      killall
      stow
      #pavucontrol
      unzip

      # Special rust tools.
      bat
      ripgrep
      bacon
      du-dust
      ncspot
      #rtx
      porsmo
      wiki-tui
      speedtest-rs
    ];
  };

  # Configure additional fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    source-code-pro
    font-awesome
  ];

  # Install firefox.
  programs.firefox.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    tree
    wget
    curl
    git

    # Languages, compilers and others
    #gnumake
    rustup
    rust-analyzer
    python3
    musl
    clang
    libgcc
    #ghc
    #pkg-config
    nodejs_22

    # For neovim-treesitter
    vimPlugins.nvim-treesitter.withAllGrammars
    tree-sitter

    # DE Gnome better looks
    gnome.gnome-tweaks
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release of the installed version.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # Auto upgrades... this is Nixos, so it won't hurt anyway
  #system.autoUpgrade.enable = true; 

  # Flakes!!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}