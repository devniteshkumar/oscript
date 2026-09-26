{ config, pkgs, ... }:

{
  home.username = "niteshk";
  home.homeDirectory = "/home/niteshk";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neovim
    git
    xwayland-satellite
  ];

  programs.home-manager.enable = true;

  xdg.configFile."niri/config.kdl".source =
    ./niri/config.kdl;
}
