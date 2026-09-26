{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Asia/Kolkata";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Niri
  programs.niri.enable = true;

  # Wayland / desktop support
  xdg.portal.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  # Polkit
  security.polkit.enable = true;

  # Login manager
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # User
  users.users.niteshk = {
    isNormalUser = true;
    description = "niteshk";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };

  # Basic tools
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
  ];

  # Enable flakes and the new nix command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # NixOS release compatibility
  system.stateVersion = "25.05";
}
