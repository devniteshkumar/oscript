{ config, pkgs, ... }:

{
  home.stateVersion = "26.05";

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.sessionVariables = {
    XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
    XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
    XDG_STATE_HOME = "${config.home.homeDirectory}/.local/state";
    ZDOTDIR = "${config.home.homeDirectory}/.config/zsh";
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXOS_OZONE_WL = "1";
  };

  # The actual dotfiles live in ./dotfiles and are linked into $HOME.
  home.file.".config/niri".source = ../dotfiles/.config/niri;
  home.file.".config/waybar".source = ../dotfiles/.config/waybar;
  home.file.".config/rofi".source = ../dotfiles/.config/rofi;
  home.file.".config/kitty".source = ../dotfiles/.config/kitty;
  home.file.".config/wlogout".source = ../dotfiles/.config/wlogout;
  home.file.".config/zsh".source = ../dotfiles/.config/zsh;
  home.file.".config/starship".source = ../dotfiles/.config/starship;
  home.file.".config/wallbash".source = ../dotfiles/.config/wallbash;
  home.file.".config/gtk-3.0".source = ../dotfiles/.config/gtk-3.0;
  home.file.".config/Kvantum".source = ../dotfiles/.config/Kvantum;
  home.file.".config/qt5ct".source = ../dotfiles/.config/qt5ct;
  home.file.".config/qt6ct".source = ../dotfiles/.config/qt6ct;
  home.file.".config/dolphinrc".source = ../dotfiles/.config/dolphinrc;
  home.file.".config/mimeapps.list".source = ../dotfiles/.config/mimeapps.list;
  home.file.".config/awww".source = ../dotfiles/.config/awww;

  home.file.".local/bin".source = ../dotfiles/.local/bin;
  home.file.".gtkrc-2.0".source = ../dotfiles/.gtkrc-2.0;
  home.file.".zshenv".source = ../dotfiles/.zshenv;

  # programs.zsh = {
  #   enable = true;
  #   dotDir = "${config.home.homeDirectory}/.config/zsh";
  # };

  programs.starship.enable = true;

  programs.waybar.enable = true;
  services.mako.enable = true;

  systemd.user.services.awww-daemon = {
    Unit = {
      Description = "awww wallpaper daemon";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.awww}/bin/awww-daemon --format argb";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  systemd.user.services.polkit-gnome = {
    Unit = {
      Description = "Polkit GNOME authentication agent";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
