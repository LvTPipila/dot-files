# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot = { 
      enable = true;
      configurationLimit = 10;
    };
    efi.canTouchEfiVariables = true;
  };

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # kernel parameters optimized for Thinkpad X220
  boot.kernelParams = [
    "acpi_backlight=vendor"
    "thinkpad_acpi.fan_control=1"
    "thinkpad_acpi.brightness_enable=1"
    "i915.enable_psr=0" # disable panel self refresh for better stability
  ];

  networking = {
    hostName = "thinkpad-x220"; # Define your hostname.
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  
  hardware = {
    trackpoint = {
      enable = true;
      emulateWheel = true;
    };

    # CPU optimization for i5-2520M
    cpu.intel.updateMicrocode = true;

    # Disable bluetooth
    bluetooth.enable = false;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # Configure keymap in X11
    xkb.layout = "us";
    xkb.options = "eurosign:e,caps:escape";
  
    # Enable i3 window manager
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        btop
        i3status
        i3lock
        i3blocks
	dmenu
      ];
    };

    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/Downloads/wallpapers/nixos_light_background.png
      xset r rate 200 35 &
    '';
    # No desktop manager
    desktopManager.xterm.enable = false;
  };

  programs.zsh.enable = true;

  # User configuration
  users.users.charlie = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" ];
    packages = with pkgs; [
      alacritty
      cmake
      gcc
      gdb
      gnumake
      go
      libgcc
      pkg-config
      python311
      neovim
      stlink
      universal-ctags
    ];
    shell = pkgs.zsh;
  }; 

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    bat
    vim
    wget
    curl
    file
    git
    home-manager
    librewolf
    lua
    neofetch
    usbutils
    # X11 utils
    xorg.xrandr
    xorg.xset
    xorg.xinit
    xorg.xbacklight
    
    xwallpaper
    feh
    arandr
  ];


  # Enable flakes
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 15d";
  };

  # Power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  # Fonts
  fonts.packages = with pkgs; [
    dejavu_fonts
    jetbrains-mono
  ];
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services = {
    libinput = {
      enable = false;
      touchpad = {
        tapping = false;
        disableWhileTyping = true;
      };
    };

    # Thermal management
    thermald.enable = true;

    # Enable the OpenSSH daemon.
    openssh.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}

