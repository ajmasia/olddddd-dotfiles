{ pkgs, ... }:

let
  USER = builtins.getEnv "USER";
  HOME_PATH = builtins.getEnv "HOME";
  EDITOR = "nvim";
in
with pkgs; {
  home = {
    username = USER;
    homeDirectory = HOME_PATH;
    stateVersion = "21.05";

    sessionVariables = {
      CM_LAUNCHER = "rofi";
    };

    keyboard = {
      layout = "us";
      variant = "altgr-intl";
    };

    packages = (import ./packages.nix) pkgs;
    file = (import ./files.nix) { };
  };

  xdg = (import ./xdg.nix) { pkgs = pkgs; };
  programs = (import ./programs.nix) { pkgs = pkgs; lib = lib; builtins = builtins; };
  services = (import ./services.nix) { };
  fonts.fontconfig.enable = true;
}


