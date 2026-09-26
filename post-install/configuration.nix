{ config, pkgs, ... }:

{
  # Niri is packaged directly by NixOS 26.05.
  programs.niri.enable = true;

  # Required services used by the rice.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  services.upower.enable = true;

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  # Niri/XWayland integration.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # The rice uses SDDM. If you already have another display manager,
  # leave SDDM disabled here and keep only one display manager enabled.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    # Niri / Wayland
    niri
    xwayland-satellite
    waybar
    mako
    rofi
    awww
    wlogout
    grim
    hyprpicker
    slurp
    satty
    cliphist
    wl-clip-persist
    wl-clipboard

    # System / desktop integration
    networkmanagerapplet
    blueman
    brightnessctl
    playerctl
    udiskie
    pavucontrol
    pamixer
    libnotify
    gnome-keyring

    # Portals / auth / utilities
    polkit_gnome
    xdg-user-dirs
    jq
    parallel
    imagemagick
    ffmpegthumbnailer
    kdePackages.kde-cli-tools
    kdePackages.ffmpegthumbs

    # Theming / Qt
    nwg-look
    qt5ct
    qt6ct
    kdePackages.qtstyleplugin-kvantum

    # Applications
    firefox
    kitty
    dolphin
    ark
    unzip
    nwg-displays
    neovim
    fzf
    btop

    # Shell
    zsh
    starship
    fastfetch
    eza
    bat
    fd
    ripgrep
    zoxide

    # Fonts
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];

  # Keep your existing hardware-configuration.nix.
  # This template assumes it is copied beside this file.
  system.stateVersion = "26.05";
}
